import strutils,sequtils

type Ranges = tuple[dest:int,source:int,length:int]

type Map = seq[Ranges]

type Interval = array[2,int]

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

proc findUpperLimit(lower:int,map:Map): int =
    var map=map.filterIt(it.source > lower)
    var min = int.high
    for elem in map:
        if elem.source < min:
            min = elem.source
    return min

#This function is supposed to, provided an interval, return all the intervals it maps to (which can overlap)
proc mapIntervals(map:Map,input:Interval): seq[Interval] =
    var lower = input[0]
    while lower < input[1]:
        block isItOnRange:
            for rang in map:
                #Check if lower limit is in some range
                if lower in rang.source..<rang.source+rang.length:
                    var diff = lower-rang.source
                    #Check if its contained
                    if input[1] < rang.source+rang.length:
                        result.add([rang.dest+diff,rang.dest+input[1]-rang.source])
                        return
                    result.add([rang.dest+diff,rang.dest+rang.length-1])
                    lower = rang.source+rang.length
                    break isItOnRange
            #Ok so we ran out of maps and did not break so its gotta be outside
            var upper = lower.findUpperLimit(map)
            #Check if its above every map
            if upper > input[1]:
                result.add([lower,input[1]])
                return 
            result.add([lower,upper-1])
            lower = upper
        
proc mapIntervals(map:Map,inputs:seq[Interval]): seq[Interval] =
    for elem in inputs:
        result &= map.mapIntervals(elem)
           

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

var intervals = newSeq[Interval]()

for i in countup(0,seeds.len-1,2):
    intervals.add([seeds[i],seeds[i]+seeds[i+1]-1])

echo intervals

for map in maps:
    intervals = map.mapIntervals(intervals)

var min = int.high

for arr in intervals:
    if min > arr[0]:
        min = arr[0]

echo min