import strutils,sequtils

type Ranges = tuple[dest:int,source:int,length:int]

type Map = seq[Ranges]

proc tryRange(input:var int,rang:Ranges): bool =
    let diff = input-rang.source
    if diff in 0..<rang.length:
        input = rang.dest+diff
        return true
    return false

proc mapValue(input:var int,map:Map) =
    for rang in map:
        if input.tryRange(rang):
            return

proc strToRange(str:string): Ranges =
    let splt = str.split(" ")
    result.dest=splt[0].parseInt
    result.source=splt[1].parseInt
    result.length=splt[2].parseInt

proc strToMap(str:string): Map =
    let splt = str.split("\n")
    for elem in splt[1..^1]:
        result.add(strToRange(elem))

proc multipleMaps(input:int,maps:seq[Map]): int =
    var copy = input
    for map in maps:
        copy.mapValue(map)
    return copy

let file = open("almanac.txt")
let content = file.readAll.split("\n\n")
close(file)

let strSeeds = content[0].split(":")[1].split(" ")[1..^1]
var seeds = newSeq[int]()
for elem in strSeeds:
    seeds.add(elem.parseInt)

var maps = newSeq[Map]()

for elem in content[1..^1]:
    maps.add(elem.strToMap)

var result = newSeqOfCap[int](seeds.len)

for elem in seeds:
    result.add(elem.multipleMaps(maps))

echo result.min