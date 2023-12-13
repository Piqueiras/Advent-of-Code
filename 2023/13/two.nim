import strutils,sequtils

func columnDiff(mirror:string,a,b:int): int =
    let mirror = mirror.split("\n")
    for i in countup(0,mirror.len-1):
        if mirror[i][a]!=mirror[i][b]:
            inc result

proc findVerticalSymmetry(mirror:string): int =
    let columns = mirror.find('\n')
    for j in countup(1,columns-1):
        var upper = j
        var lower = j-1
        var diffs = newSeq[int]()
        block checking:  
            while lower>=0 and upper<columns:
                diffs.add(mirror.columnDiff(lower,upper))
                if diffs[^1] <= 1:
                    inc upper
                    dec lower
                else:
                    break checking
            if diffs.count(1)!=1:
                break checking
            return j
    return 0

func rowDiff(mirror:string,a,b:int): int =
    let mirror = mirror.split("\n")
    return zip(mirror[a],mirror[b]).countIt(it[0]!=it[1])      

proc findHorizontalSymmetry(mirror:string): int =
    let rows = mirror.count('\n')+1
    for i in countup(1,rows-1):
        var upper = i
        var lower = i-1
        var diffs = newSeq[int]()
        block checking:  
            while lower>=0 and upper<rows:
                diffs.add(mirror.rowDiff(lower,upper))
                if diffs[^1] <= 1:
                    inc upper
                    dec lower
                else:
                    break checking
            if diffs.count(1)!=1:
                break checking
            return i
    return 0

let file = open("mirrors.txt")

let mirrors = file.readAll.split("\n\n")

var sum = 0

for mirror in mirrors:
    sum += 100*findHorizontalSymmetry(mirror)
    sum += findVerticalSymmetry(mirror)

echo sum