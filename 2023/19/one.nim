import sequtils, strutils, algorithm, tables

type Part = Table[char,int]

func strToPart(input:string): Part = 
    let stats = input[1..^2].split(",").mapIt(it.split("=")[1].parseInt)
    result['x'] = stats[0]
    result['m'] = stats[1]
    result['a'] = stats[2]
    result['s'] = stats[3]

type Condition = tuple
  id: char
  ran: Slice[int]
  final: string

func strToCondition(input:string): Condition =
    let sep = input.split(":")
    result.final = sep[1]
    result.id = sep[0][0]
    if sep[0][1]=='<':
        result.ran = 0..parseInt(sep[0][2..^1])-1
    elif sep[0][1]=='>':
        result.ran = parseInt(sep[0][2..^1])+1..int.high

type Flow = tuple
    name: string
    conds: seq[Condition]
    final: string

func strToFlow(input:string): Flow =
    let first = input.split("{")
    result.name = first[0]
    let second = first[1][0..^2].split(",")
    result.final = second[^1]
    result.conds = second[0..^2].mapIt(it.strToCondition)

func `cmp`(a,b:Flow): int = cmp(a.name,b.name)
func `cmp`(a:Flow,b:string): int = cmp(a.name,b)
func `==` (a,b:Flow): bool = a.name == b.name

let input = open("flows.txt").readAll().split("\n\n")

let flows = input[0].split("\n").map(strToFlow).sorted(cmp)
let parts = input[1].split("\n").map(strToPart)

proc accepts(flows:seq[Flow],part:Part): bool =
    var next = "in"
    while true:
        var current = flows[flows.binarySearch(next,cmp)]
        for cond in current.conds:
            if part[cond.id] in cond.ran:
                next = cond.final
                break
            next = current.final
        if next == "A":
            return true
        if next == "R":
            return false      
    
var sum = 0
for part in parts:
    if flows.accepts(part):
        sum += part['x'] + part['m'] + part['a'] + part['s']

echo sum