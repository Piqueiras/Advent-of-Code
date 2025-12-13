import strutils,sequtils

const MAX = 142
let lines = readLines("lasers.txt",MAX)
let width = lines[0].len
var starter = lines[0].find('S')

proc split(line,pos:int): int =
    var line = line
    while lines[line][pos] != '^':
        inc line
        echo line
        if line >= MAX:
            return 1
    return split(line+1,pos-1) + split(line+1,pos+1)
        
echo split(0,starter)