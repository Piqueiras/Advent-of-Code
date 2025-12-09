import strutils

var dial = 50
var suma = 0

let file = open("rotations.txt")

for line in file.lines:
    var delta = line[1..^1].strip().parseInt()
    if line[0]=='R':
        dial += delta
    else:
        dial -= delta
    if dial mod 100 == 0:
        inc suma

echo suma