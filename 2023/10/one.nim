import strutils,sequtils

type Direction = enum Up, Down, Left, Right, Start

type Pipe = set[Direction]

func charToPipe(c:char): Pipe =
    case c:
        of '|':
            return {Up,Down}
        of '-':
            return {Left,Right}
        of 'L':
            return {Up,Right}
        of 'J':
            return {Up,Left}
        of '7':
            return {Down,Left}
        of 'F':
            return {Down,Right}
        of 'S':
            return {Start}
        else:
            return {}

#[ type Tile = object
    location : tuple[x,y:int]
    pipe : Pipe
    distance : int ]#

let file = open("pipes.txt")

let text = file.readAll.split("\n")

var matrix = newSeqOfCap[seq[Pipe]](140)

var coords = [0,0]

for i,line in text:
    var minimatrix = newSeqOfCap[Pipe](140)
    for j,c in line:
        if c == 'S':
            coords = [i,j]
        minimatrix.add(charToPipe(c))
    matrix.add(minimatrix)

echo coords

#Hardcoded fact: Theres a - rigth of the start

proc move(coords:var array[2,int],dir:Direction) =
    case dir:
        of Up:
            dec coords[0]
        of Down:
            inc coords[0]
        of Right:
            inc coords[1]
        of Left:
            dec coords[1]
        else:
            discard

func inverse(dir:Direction): Direction =
    case dir:
        of Up:
            return Down
        of Down:
            return Up
        of Right:
            return Left
        of Left:
            return Right
        else:
            discard
    

var count = 0
var dir = Right
while Start notin matrix[coords[0]][coords[1]] or count == 0:
    inc count
    coords.move(dir)
    #This should have a single element now
    for pipe in matrix[coords[0]][coords[1]] - {inverse(dir)}:
        dir = pipe

echo count div 2