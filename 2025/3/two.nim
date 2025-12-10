import strutils

const SIZE = 100
const JOLTAGE = 12

type Battery = array[SIZE, int]

func toBattery(s:string): Battery =
    for i in 0..<SIZE:
        result[i] = int(s[i]) - int('0')

var suma = 0

let file = open("batteries.txt")

for line in file.lines:
    var result : array[JOLTAGE, int]
    var battery = line.toBattery()
    var found = 0
    var idx = 0
    while found<JOLTAGE:
        var temp = idx
        for i in temp..SIZE-JOLTAGE+found:
            if battery[i] > battery[idx]:
                idx = i

        result[found] = battery[idx]        
        inc found
        inc idx
        
    
    #echo join(result,"")
    suma += join(result,"").parseInt()

echo suma