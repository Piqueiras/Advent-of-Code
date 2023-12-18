import strutils,sequtils

func superAnonymousProc(input:seq[string]): (char,int) =
    result[0] = input[0][0]
    result[1] = input[1].parseInt

func hexadecimalAnonymousProc(input:seq[string]): (char,int) =
    let hex = input[2][2..^2]
    result[0] = case hex[^1]:
        of '0' : 'R'
        of '1' : 'D'
        of '2' : 'L'
        of '3' : 'U'
        else: 'X'
    result[1] = parseHexInt(hex[0..^2])

let indications = open("trench.txt").readAll.split("\n").mapIt(it.split(" ")).mapIt(it.superAnonymousProc)

func turnRight(c:char): char =
    case c:
        of 'U':
            return 'R'
        of 'D':
            return 'L'
        of 'L':
            return 'U'
        of 'R':
            return 'D'
        else:
            return c

#Trust me bro
var rightTurns = newSeqOfCap[bool](indications.len)

rightTurns.add(indications[0][0] == turnRight(indications[^1][0]))

for i in countup(1,indications.len-1):
    rightTurns.add(indications[i][0] == turnRight(indications[i-1][0]))

echo rightTurns

type Coords = array[2,int]

func moved(input:Coords,dir:char,steps:int): Coords =
    case dir:
        of 'U':
            return [input[0]-steps,input[1]]
        of 'D':
            return [input[0]+steps,input[1]]
        of 'L':
            return [input[0],input[1]-steps]
        of 'R':
            return [input[0],input[1]+steps]
        else:
            return input

var points = @[[0,0]]

for i in countup(0,indications.len-2):
    let thisPoint = points[^1]
    let nextPoint = thisPoint.moved(indications[i][0],indications[i][1]+1-rightTurns[i..i+1].count(false))
    points.add(nextPoint)

points.add([0,0])

echo points

var area = 0
for i in countup(1,points.len-1):
    area += points[i][0]*points[i-1][1] - points[i][1]*points[i-1][0]

echo abs(area) / 2