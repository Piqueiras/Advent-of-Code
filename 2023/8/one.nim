import strutils,algorithm

type
    Label = tuple
        current: string
        left: string
        right: string

proc strToLabel(str:string): Label =
    result.current = str[0..2]
    result.left = str[7..9]
    result.right = str[12..14]

proc cmp(l1,l2:Label): int = cmp(l1.current,l2.current)

proc cmp(label:Label,str:string): int = cmp(label.current,str)

proc find(labels:seq[Label],key:string): Label = labels[labels.binarySearch(key,cmp)]

let file = open("nodes.txt")
let split = file.readAll.split("\n\n")
let directions = split[0]
var labels = newSeqOfCap[Label](755)
for str in split[1].split("\n"):
    labels.add(str.strToLabel)

labels.sort

var i = 0

var curr = labels.find("AAA")

while curr.current!="ZZZ":
    echo curr
    let next = (if directions[i mod directions.len]=='L': curr.left else: curr.right)
    inc i
    curr = labels.find(next)

echo i