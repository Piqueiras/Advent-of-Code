import strutils,sequtils

type Operation = object
    op: char
    values: array[4, int]

func compute(o:Operation): int =
    if o.op=='+':
        return o.values[0] + o.values[1] + o.values[2] + o.values[3]
    elif o.op=='*':
        return o.values[0] * o.values[1] * o.values[2] * o.values[3]

let file = open("math.txt")

var tempNums : array[4,seq[int]]

for i in 0..3:
    tempNums[i] = file.readLine().splitWhitespace().map(parseInt)

let tempOps = file.readLine().splitWhitespace()

var operations: seq[Operation] = newSeqOfCap[Operation](tempOps.len)

var sum = 0

for i in 0..<tempOps.len:
    let operation = Operation(
        op: tempOps[i][0],
        values: [tempNums[0][i], tempNums[1][i], tempNums[2][i], tempNums[3][i]]
    )
    operations.add(operation)
    sum += compute(operation)

echo sum