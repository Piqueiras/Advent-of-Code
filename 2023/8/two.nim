import strutils,algorithm,math

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

# Wanna know what? This doesnt work
# Thank god I know math and there is this thing called the lcm

#[ var iteration = newSeq[Label]()

for elem in labels:
    if elem.current[2]=='A':
        iteration.add(elem)

echo iteration

var i = 0

proc apply(labels:seq[Label],iteration:var seq[Label],direction:char) =
    if direction == 'L':
        for elem in iteration.mitems:
            elem = labels.find(elem.left)
        return
    if direction == 'R':
        for elem in iteration.mitems:
            elem = labels.find(elem.right)
        return

proc isDone(iteration:seq[Label]): bool =
    for elem in iteration:
        if elem.current[2]!='Z':
            return false
    return true

while not iteration.isDone:
    apply(labels,iteration,directions[i mod directions.len])
    inc i

echo i ]#

var iteration = newSeq[Label]()

for elem in labels:
    if elem.current[2]=='A':
        iteration.add(elem)

var costs = newSeq[int]()

for i in 0..<iteration.len:
    var count = 0
    var curr = iteration[i]
    while curr.current[2]!='Z':
        let next = (if directions[count mod directions.len]=='L': curr.left else: curr.right)
        inc count
        curr = labels.find(next)
    costs.add(count)

echo costs.lcm
# I swear I did not think it would actually work