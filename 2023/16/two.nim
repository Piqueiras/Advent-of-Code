import strutils,sequtils,sets

let text =  open("beams.txt").readAll.split("\n")
let SIZE = text.len

type Direction = enum Up, Left, Down, Right

type Coords = array[2,int]

type Beam = tuple[loc:Coords,dir:Direction] 

template `[]`(matrix: seq[string], idx: array[2, int]): char = matrix[idx[0]][idx[1]]

proc advance(beam:var Beam) =
    case beam.dir:
        of Up:
            dec beam.loc[0]
        of Down:
            inc beam.loc[0]
        of Left:
            dec beam.loc[1]
        of Right:
            inc beam.loc[1]

proc advance(beams:var seq[Beam]) =
    var i = 0
    while i<beams.len:
        let beam = beams[i]
        #Horizontal beam finds a |
        if beam.dir in {Left,Right} and text[beam.loc]=='|':
            beams.insert(beam,i) #Clone it
            beams[i].dir = Up
            beams[i].advance
            beams[i+1].dir = Down
            beams[i+1].advance
            i+=2
            continue
        #Vertical beam finds a -
        if beam.dir in {Up,Down} and text[beam.loc]=='-':
            beams.insert(beam,i) #Clone it
            beams[i].dir = Left
            beams[i].advance
            beams[i+1].dir = Right
            beams[i+1].advance
            i+=2
            continue
        #Encounters a \
        if text[beam.loc]=='\\':
            case beam.dir:
                of Up:
                    beams[i].dir = Left
                of Down:
                    beams[i].dir = Right
                of Left:
                    beams[i].dir = Up
                of Right:
                    beams[i].dir = Down
            beams[i].advance
            inc i
            continue
        #Encounters a \
        if text[beam.loc]=='/':
            case beam.dir:
                of Up:
                    beams[i].dir = Right
                of Down:
                    beams[i].dir = Left
                of Left:
                    beams[i].dir = Down
                of Right:
                    beams[i].dir = Up
            beams[i].advance
            inc i
            continue
        #Else
        beams[i].advance
        inc i
    #Check boundaries
    beams.keepItIf(it.loc[0] in 0..SIZE-1 and it.loc[1] in 0..SIZE-1)

var initials = newSeqOfCap[Beam](4*SIZE)
for i in 0..<SIZE:
    initials.add(([i,0],Right))
    initials.add(([i,SIZE-1],Left))
    initials.add(([0,i],Down))
    initials.add(([SIZE-1,i],Up))
        
var max = 0

for initial in initials:
    var beams = @[initial]
    var energized = initHashSet[Coords]()
    var visited = initHashSet[Beam]()
    while beams.len>0:
        beams.keepItIf(it notin visited)
        for beam in beams:
            visited.incl(beam)
            energized.incl(beam.loc)
        beams.advance
    max = max(max,energized.len)

echo max