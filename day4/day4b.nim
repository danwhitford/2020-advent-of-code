import strutils
import tables
import re

func intBetween(s: string, min, max: int): bool =
    let i = s.parseInt
    min <= i and i <= max

func validBirth(s: string): bool =
    s.intBetween(1920, 2002)

func validIssue(s: string): bool =
    s.intBetween(2010, 2020)

func validExpiration(s: string): bool =
    s.intBetween(2020, 2030)

func validHeight(s: string): bool =
    if s.endsWith("in"):
        return s.replace("in", "").intBetween(59, 76)
    elif s.endsWith("cm"):
        return s.replace("cm", "").intBetween(150, 193)
    false

func validHair(s: string): bool =
    match(s, re"#[a-f0-9]{6}")

func validEye(s: string): bool =
    s in [
        "amb", "blu", "brn", "gry", "grn", "hzl", "oth",
    ]

func validPid(s: string): bool =
    match(s, re"\b[0-9]{9}\b")

const validationTable = {
    "byr": validBirth,
    "iyr": validIssue,
    "eyr": validExpiration,
    "hgt": validHeight,
    "hcl": validHair,
    "ecl": validEye,
    "pid": validPid,
}.toTable

proc getPassport(f: File): seq[string] =
    while not stdin.endOfFile:
        var line = f.readLine
        if line == "":
            break
        result.add(line.split(" "))

func getPassportPairs(passport: seq[string]): Table[string, string] =
    for s in passport:
        let sp = s.split(":")
        if sp.len > 1:
            result[sp[0]] = sp[1]

func isValid(passportFields: Table[string, string]): bool =
    for key, validationFn in validationTable.pairs:
        if key in passportFields:
            if not validationFn(passportFields[key]):
                return false
        else:
            return false
    return true

proc countValid(f: File): int =
    while not f.endOfFile:
        let pass = f.getPassport
        if pass.getPassportPairs.isValid:
            inc result

echo stdin.countValid
