import strutils
import sequtils
import sugar

let input = readAll(stdin).splitLines
let grid = input.map(line => line.toSeq)
let height = grid.high
let width = grid[0].high

func charAt(grid: seq[seq[char]]; t: (int, int)): char =
    grid[t[0]][t[1]]

proc move(pos: var (int, int), down: int, right: int) =
    var (v, h) = pos
    v += down
    h += right
    assert v <= height
    if h > width:
        h = h mod (width + 1)
    pos = (v, h)

proc findTreeCount(slope: (int, int)): int =
    let (v, h) = slope
    var pos = (0,0)
    while pos[0] < height:
        pos.move(v, h)
        if grid.charAt(pos) == '#':
            inc result

let slopes = [
    (1, 1),
    (1, 3),
    (1, 5),
    (1, 7),
    (2, 1)
]

let res = slopes.map(findTreeCount).foldl(a * b)
echo res
