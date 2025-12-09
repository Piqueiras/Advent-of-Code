import strutils

var dial = 100050
var suma = 0

let file = open("rotations.txt")

for line in file.lines:
    var delta = line[1..^1].strip().parseInt()

    suma += (delta div 100)
    delta = delta mod 100

    if line[0]=='R':
        if delta > 100 - (dial mod 100):
            inc suma
        dial += delta
    else:
        if delta > (dial mod 100) and dial mod 100 != 0:
            inc suma
        dial -= delta

    if dial mod 100 == 0:
        inc suma

echo suma