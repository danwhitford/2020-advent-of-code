import strutils
import sequtils

func occurances(s: string, c: char): int =
    for cc in s:
        if cc == c:
            result += 1

func getRange(s: string): (int, int) =
    let minMax = s.split(" ")[0].split("-").map(parseInt)
    (minMax[0], minMax[1])

func getChar(s: string): char =
    s.split(" ")[1][0]

func getPwd(s: string): string =
    s.split(" ")[2]

func checkPwd(min: int, max: int, c: char, pwd: string): bool =
    let o = occurances(pwd, c)
    o >= min and o <= max

func countValid(lines: openArray[string]): int =
    for line in lines:
        let
            (min, max) = getRange(line)
            c = getChar(line)
            pwd = getPwd(line)
        if checkPwd(min, max, c, pwd):
            result += 1

# const input = [
#     "1-3 a: abcde",
#     "1-3 b: cdefg",
#     "2-9 c: ccccccccc"
# ]

let input = readAll(stdin).splitLines

echo countValid(input)
