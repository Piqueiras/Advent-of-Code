import strutils,sequtils

func hash(str:string): int =
    for c in str:
       result += int(c)
       result *= 17
       result = result mod 256

let file = open("steps.txt")
let steps = file.readAll.split(",")
var sum = 0
for elem in steps: sum += hash(elem)
echo sum

type Lens = tuple[label:string,power:int]
func `$`(lens:Lens): string = "[" & lens.label & " " & $lens.power & "]"
func `==`(a,b:Lens): bool = a.label == b.label

#Gonna treat 0 focal len like a -
func strToLens(str:string): Lens =
    if str[^1]=='-':
        return (str[0..^2],0)
    else:
        return (str[0..^3],int(str[^1])-int('0'))

func hash(lens:Lens): int = hash(lens.label)

type Box = seq[Lens]

var boxes : array[256,Box]
let lenses = steps.map(strToLens)

for lens in lenses:
    let hash = lens.hash
    if lens.power==0 and lens in boxes[hash]:
        boxes[hash].delete(boxes[hash].find(lens))
    elif lens.power!=0:
        if lens in boxes[hash]:
            boxes[hash][boxes[hash].find(lens)].power = lens.power
        else:
            boxes[hash].add(lens)

sum = 0

for i,box in boxes:
    for j,lens in box:
        sum += (i+1)*(j+1)*(lens.power)

echo sum