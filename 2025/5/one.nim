import strutils,algorithm

type Range = tuple[lower, higher: int]

func `cmp`(a,b:Range): int = cmp(a.lower,b.lower)
    
func between(x:int, r:Range): bool = x >= r.lower and x <= r.higher

let file = open("ingredients.txt")
var ranges = newSeq[Range]()
var food = newSeq[int]()

var line = file.readLine()

while line!="":
    let parts = line.split('-')
    ranges.add((lower: parseInt(parts[0]), higher: parseInt(parts[1])))
    line = file.readLine()

for line in file.lines:
    food.add(parseInt(line))

ranges.sort()
food.sort()
var numFresh = 0

for ingredient in food:
    for ran in ranges:
        if ingredient.between(ran):   #El ingrediente es fresco por estar en un rango
            inc numFresh
            break

echo numFresh