import strutils,sequtils

let file = open("lasers.txt")

var line = file.readLine()

let width = line.len

var lasers : seq[bool] = line.mapIt(it == 'S')

var splits = 0

for line in file.lines():
    for i in 0..<width:
        if line[i] == '^' and lasers[i]:
            splits += 1
            lasers[i] = false
            lasers[i+1] = true
            lasers[i-1] = true
            
echo splits