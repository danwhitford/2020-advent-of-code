import strutils
import sequtils

func getRange(s: string): (int, int) =
    let minMax = s.split(" ")[0].split("-").map(parseInt)
    (minMax[0], minMax[1])

func getChar(s: string): char =
    s.split(" ")[1][0]

func getPwd(s: string): string =
    s.split(" ")[2]

func checkPwd(min: int, max: int, c: char, pwd: string): bool =
    pwd[min - 1] == c xor pwd[max - 1] == c

func countValid(lines: openArray[string]): int =
    for line in lines:
        let
            (min, max) = getRange(line)
            c = getChar(line)
            pwd = getPwd(line)
        if checkPwd(min, max, c, pwd):
            result += 1

let input = readAll(stdin).splitLines

echo countValid(input)
