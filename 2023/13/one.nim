import strutils,sequtils

func areColumnsEqual(mirror:string,a,b:int): bool =
    let mirror = mirror.split("\n")
    for i in countup(0,mirror.len-1):
        if mirror[i][a]!=mirror[i][b]:
            return false
    return true

func findVerticalSymmetry(mirror:string): int =
    let columns = mirror.find('\n')
    for j in countup(1,columns-1):
        var upper = j
        var lower = j-1
        block checking:  
            while lower>=0 and upper<columns:
                if mirror.areColumnsEqual(lower,upper):
                    inc upper
                    dec lower
                else:
                    break checking
            return j
    return 0

func areRowsEqual(mirror:string,a,b:int): bool =
    let mirror = mirror.split("\n")
    return mirror[a] == mirror[b]       

func findHorizontalSymmetry(mirror:string): int =
    let rows = mirror.count('\n')+1
    for i in countup(1,rows-1):
        var upper = i
        var lower = i-1
        block checking:  
            while lower>=0 and upper<rows:
                if mirror.areRowsEqual(lower,upper):
                    inc upper
                    dec lower
                else:
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