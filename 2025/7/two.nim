import strutils, sequtils

const MAX = 142
let lines = readLines("lasers.txt", MAX)
let width = lines[0].len
var starter = lines[0].find('S')

var iLoveDynamicProgramming = newSeq[seq[int64]](MAX)
# Poner todo a -1
for i in 0..<MAX:
    iLoveDynamicProgramming[i] = newSeq[int64](width)
    for j in 0..<width:
        iLoveDynamicProgramming[i][j] = -1

proc split(line,pos:int): int64 =
    var line = line
    while lines[line][pos] != '^':
        inc line
        if line >= MAX:
            return 1
    # Se guarda para no calcular mas veces
    if iLoveDynamicProgramming[line][pos] != -1: 
        return iLoveDynamicProgramming[line][pos]
    iLoveDynamicProgramming[line][pos] = split(line+1, pos-1) + split(line+1, pos+1)
    return iLoveDynamicProgramming[line][pos]
        
echo split(0,starter)
