import strutils
import sequtils
import sugar

const requiredFields = [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid",
]

proc getPassport(f: File): seq[string] =
    var pass: seq[string] = @[]
    while not stdin.endOfFile:
        var line = f.readLine
        if line == "":
            break
        pass.add(line.split(" "))
    pass

func getPassportFields(passport: seq[string]): seq[string] =
    passport.map(s => s.split(":")[0])

func isValid(passportFields: seq[string]): bool =
    requiredFields.all(f => f in passportFields)

proc countValid(f: File): int =
    while not f.endOfFile:
        let pass = f.getPassport
        if pass.getPassportFields.isValid:
            inc result

echo stdin.countValid
