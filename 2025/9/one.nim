import strutils,sequtils,algorithm

type Coords = tuple[x,y: int]

func manhattan(a,b:Coords): int = abs(a.x - b.x) + abs(a.y - b.y)

func area(a,b:Coords): int = (abs(a.x - b.x) + 1) * (abs(a.y - b.y) + 1)

func closest(pt: Coords, points: seq[Coords]): Coords =
    result = points[0]
    var bestDist = manhattan(pt, result)
    for p in points[1..^1]:
        let dist = manhattan(pt, p)
        if dist < bestDist:
            bestDist = dist
            result = p

let file = open("tiles.txt")

var tiles : seq[Coords] = @[]

var maxX = 0
var maxY = 0

for line in file.lines:
    var parts = line.split(",")
    let x = parseInt(parts[0].strip())
    let y = parseInt(parts[1].strip())
    if x > maxX: maxX = x
    if y > maxY: maxY = y
    tiles.add((x, y))

let upperLeft: Coords = (0,0)
let upperRight: Coords = (maxX, 0)
let lowerLeft: Coords = (0, maxY)
let lowerRight: Coords = (maxX, maxY)
let closeUpperLeft = upperLeft.closest(tiles)
let closeUpperRight = upperRight.closest(tiles)
let closeLowerLeft = lowerLeft.closest(tiles)
let closeLowerRight = lowerRight.closest(tiles)

echo area(closeUpperLeft,closeLowerRight)
echo area(closeUpperRight,closeLowerLeft)

# No pense que fuese a funcionar lo hice de broma