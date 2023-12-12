import strutils

type Coords = array[2,int]

func taxiDistance(a,b:Coords): Natural = abs(a[0]-b[0]) + abs(a[1]-b[1])
    
let file = open("galaxies.txt")

let text = file.readAll.split("\n")

var horizontalExpansion, verticalExpansion : seq[int]

for i in 0..<text.len:
    block horizontal:
        for j in 0..<text[0].len:
            if text[i][j]=='#':
                break horizontal
        horizontalExpansion.add(i)

for j in 0..<text[0].len:
    block vertical:
        for i in 0..<text.len:
            if text[i][j]=='#':
                break vertical
        verticalExpansion.add(j)

echo horizontalExpansion
echo verticalExpansion

var galaxies = newSeq[Coords]()

for i in 0..<text.len:
    for j in 0..<text[0].len:
        if text[i][j]=='#':
            galaxies.add([i,j])

func galaxyDistance(a,b:Coords,h,v:seq[int],increase:int): Natural =
    result = taxiDistance(a,b)
    for elem in h:
        if elem in min(a[0],b[0])..max(a[0],b[0]):
            result += increase
    for elem in v:
        if elem in min(a[1],b[1])..max(a[1],b[1]):
            result += increase

var sum = 0

for i in countup(0,galaxies.len-1):
    for j in countup(i+1,galaxies.len-1):
        sum += galaxyDistance(galaxies[i],galaxies[j],horizontalExpansion,verticalExpansion,999999)

echo sum