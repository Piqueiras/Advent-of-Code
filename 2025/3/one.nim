import strutils

const MAX = 100

type Battery = array[0..MAX-1, int]

func toBattery(s:string): Battery =
    for i in 0..MAX-1:
        result[i] = int(s[i]) - int('0')

var suma = 0

let file = open("batteries.txt")

for line in file.lines:
    var battery = line.toBattery()
    var idx1 = 0
    var idx2 = 0

    for i in 0..MAX-2:
        if battery[i] > battery[idx1]:
            idx1 = i
    idx2 = idx1+1
    for i in idx1+1..MAX-1:
        if battery[i] > battery[idx2]:
            idx2 = i
    
    #echo battery[idx1] * 10 + battery[idx2]
    suma += battery[idx1] * 10 + battery[idx2]

echo suma