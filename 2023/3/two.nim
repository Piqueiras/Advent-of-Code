import strutils,sequtils,algorithm,math

const Symbols = {'*'}

type Coords = array[2,int]

proc isAdyacent(this,that:Coords): bool = this[0] in that[0]-1..that[0]+1 and this[1] in that[1]-1..that[1]+1

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

proc isAdyacent(number:NumberLocation,symbol:Coords): bool =
    for digit in number:
        if isAdyacent(digit,symbol):
            return true
    return false

proc searchSurroundingNumbers(map:NumberMap,symbol:Coords): NumberMap =
    for number in map:
        if number.isAdyacent(symbol):
            result.add(number)

var gearRatios = newSeq[NumberMap]()
for gear in map:
    gearRatios.add(numLocations.searchSurroundingNumbers(gear))

gearRatios = gearRatios.filterIt(it.len == 2)

echo gearRatios

#This is an array of pairs of number locators

proc toInt(c:char): int = int(c)-int('0')

proc readNumber(text:seq[string],number:NumberLocation): int =
    for k,digit in number.reversed:
        result += (text[digit[0]][digit[1]].toInt * 10^k)

let textMatrix = open("engine.txt").readAll.splitLines

var sum = 0
for pair in gearRatios:
    var ratio = 1
    for number in pair:
        ratio *= textMatrix.readNumber(number)
    sum += ratio

echo sum