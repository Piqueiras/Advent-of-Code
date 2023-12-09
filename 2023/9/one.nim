import sequtils,strutils

func diff(input:seq[int]): seq[int] =
    for i in countup(1,input.len-1):
        result.add(input[i]-input[i-1])

func isZero(input:seq[int]): bool = input.allIt(it == 0)

func extrapolate(input:seq[int]): int =
    var manySeqs = @[input]

    while not isZero(manySeqs[^1]):
        manySeqs.add(diff(manySeqs[^1]))

    for i in countdown(manySeqs.len-1,1):
        manySeqs[i-1].add(manySeqs[i-1][^1] + manySeqs[i][^1])

    return manySeqs[0][^1]

let file = open("sequences.txt")

var sum = 0

for line in file.lines:
    var input = newSeq[int]()
    for elem in line.split(" "):
        input.add(elem.parseInt)
    sum += extrapolate(input)

echo sum