import strutils,sequtils

func processColumn(a,b,c,d:char): int =
    func digit(ch: char): int = ord(ch) - ord('0')

    let ai = if a != ' ': digit(a) else: 0
    let bi = if b != ' ': digit(b) else: 0
    let ci = if c != ' ': digit(c) else: 0
    let di = if d != ' ': digit(d) else: 0

    if a != ' ':
        if d != ' ':
            return ai * 1000 + bi * 100 + ci * 10 + di
        elif c != ' ':
            return ai * 100 + bi * 10 + ci
        elif b != ' ':
            return ai * 10 + bi
        else:
            return ai
    else:
        return bi * 100 + ci * 10 + di


let lines = readLines("math.txt",5)

let chars = lines[4]

var suma = 0

var currentChar: char
var values: seq[int]

for i in 0..<chars.len:
    if chars[i] in {'+','*'}:
        currentChar = chars[i]
        values = newSeq[int]()
    let colValue = processColumn(lines[0][i], lines[1][i], lines[2][i], lines[3][i])
    if colValue == 0:
        if currentChar == '+':
            suma += values.foldl(a+b,0)
        elif currentChar == '*':
            suma += values.foldl(a*b,1)
    else:
        values.add(colValue)

echo suma
