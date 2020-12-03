import strutils
import sequtils
import sugar

let input = readAll(stdin).splitLines
let grid = input.map(line => line.toSeq)
let height = grid.high
let width = grid[0].high

func charAt(grid: seq[seq[char]]; t: (int, int)): char =
    grid[t[0]][t[1]]

proc move(pos: var (int, int); down: int; right: int) =
    var (v, h) = pos
    v += down
    h += right
    assert v <= height
    if h > width:
        h = h mod (width + 1)
    pos = (v, h)

var pos = (0, 0)
var count = 0

while pos[0] < height:
    pos.move(1, 3)
    if grid.charAt(pos) == '#':
        inc count

echo count
