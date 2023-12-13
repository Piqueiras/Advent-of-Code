import sequtils,strutils,math,bitops

type Row = tuple[arr:string,pos:seq[int]]

iterator fillPermutations(input:string): string =

    var locations = newSeq[int]()
    for i in 0..<input.len:
        if input[i]=='?':
            locations.add(i)

    for i in 0..<2^len(locations):
        var copy = input
        for j in 0..<len(locations):
            copy[locations[j]] = if i.bitsliced(j..j) == 0: '.' else: '#'
        yield copy

func countGroups(input:string): seq[int] = input.split('.').filterIt(it!="").mapIt(it.len)

func countValids(row:Row): int =
    for attempt in fillPermutations(row.arr):
        if attempt.countGroups == row.pos:
            inc result

let file = open("springs.txt")

var sum = 0

for line in file.lines:
    var splitline = line.split(" ")
    var row : Row
    row.arr = splitline[0]
    for num in splitline[1].split(","):
        row.pos.add(num.parseInt)
    sum += row.countValids

echo sum

