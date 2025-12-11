import strutils,algorithm

type Range = tuple[lower, higher: int]

func `cmp`(a,b:Range): int = cmp(a.lower,b.lower)

let file = open("ingredients.txt")
var ranges = newSeq[Range]()

var line = file.readLine()
while line!="":
    let parts = line.split('-')
    ranges.add((lower: parseInt(parts[0]), higher: parseInt(parts[1])))
    line = file.readLine()

file.close()

ranges.sort()

var total = 0
var maxPrev = 0

for ran in ranges:
    if ran.higher <= maxPrev:   #El rango esta ya completamente cubierto de antes
        continue
    else:
        if ran.lower > maxPrev: #No se solapa
            total += ran.higher - ran.lower + 1
        else: #Se solapa
            total += ran.higher - maxPrev
        maxPrev = ran.higher
    

echo total