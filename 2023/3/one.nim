import strutils,sequtils,algorithm,math

const Symbols = PunctuationChars - {'.'}

type Coords = array[2,int]

type SymbolMap = seq[Coords]

proc toSymbolMap(fileStr:string): SymbolMap =
    let file = open(fileStr)
    var i = 0
    for line in file.lines:
        var j = 0
        for c in line:
            if c in Symbols:
                result.add([i,j])
            inc j    
        inc i
    file.close()

proc checkSurrounding(map:SymbolMap,coord:Coords): bool =
    for i in countup(coord[0]-1,coord[0]+1):
        for j in countup(coord[1]-1,coord[1]+1):
            if [i,j] in map:
                return true
    return false  

type NumberLocation = seq[Coords]

type NumberMap = seq[NumberLocation]

proc checkSurrounding(map:SymbolMap,coords:NumberLocation): bool =
    for coord in coords:
        if map.checkSurrounding(coord):
            return true   
    return false    

proc toNumberMap(fileStr:string): NumberMap =
    let file = open(fileStr) 
    var i = 0
    for line in file.lines:
        var j = 0
        while j < line.len:
            if (line[j].isDigit and (j==0 or not line[j-1].isDigit())):
                var numLocation = @[[i,j]]
                while j+1 < line.len and line[j+1].isDigit:
                    inc j
                    numLocation.add([i,j])
                result.add(numLocation)
            inc j        
        inc i            
    file.close()

let map = toSymbolMap("engine.txt")

var numLocations = toNumberMap("engine.txt")

numLocations = numLocations.filterIt(map.checkSurrounding(it))

#We now have coords of the numbers

let textMatrix = open("engine.txt").readAll.splitLines

proc toInt(c:char): int = int(c)-int('0')

proc readNumber(text:seq[string],number:NumberLocation): int =
    for k,digit in number.reversed:
        result += (text[digit[0]][digit[1]].toInt * 10^k)

var sum = 0
for numLocation in numLocations:
    sum += textMatrix.readNumber(numLocation)
    

echo sum