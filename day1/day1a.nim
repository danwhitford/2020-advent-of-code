import strutils
import sequtils
import sugar

# Credit to https://forum.nim-lang.org/t/2812
proc comb[T](a: openarray[T]; n: int; use: seq[bool]): seq[seq[T]] =
  result = newSeq[seq[T]]()
  var use = use
  if n <= 0: return
  for i in 0  .. a.high:
    if not use[i]:
      if n == 1:
        result.add(@[a[i]])
      else:
        use[i] = true
        for j in comb(a, n - 1, use):
          result.add(a[i] & j)

# Credit to https://forum.nim-lang.org/t/2812
proc combinations[T](a: openarray[T], n: int): seq[seq[T]] =
  var use = newSeq[bool](a.len)
  comb(a, n, use)

proc head[T](s: seq[T]): T =
    s[0]

let foo = readAll(stdin).splitLines()
    .map(parseInt)
    .combinations(3)
    .filter(x => x.foldl(a + b) == 2020)
    .map(x => x.foldl(a * b))
    .head

echo foo
