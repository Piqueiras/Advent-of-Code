{.experimental: "views".}

import strutils,sequtils,sugar,sets

type Direction = enum Up, Left, Down, Right

proc tiltSection(text:var seq[string],rows,cols:Slice[int],dir:Direction) =
    if (rows.a==rows.b and dir in {Up,Down}) or (cols.a==cols.b and dir in {Right,Left}):
        return #Do nothing cause ur stupid and input it wrong
    if rows.a==rows.b:  #Horizontal
        var reference = text[rows.a].toOpenArray(cols.a,cols.b)
        let count = reference.count('O')
        if count==0:
            return
        if dir == Left:
            for i in 0..<count:
                reference[i]='O'
            for i in count..<reference.len:
                reference[i]='.'
            return
        if dir == Right:
            for i in 0..<reference.len-count:
                reference[i]='.'
            for i in reference.len-count..<reference.len:
                reference[i]='O'
            return
    if cols.a==cols.b:  #Vertical
        var notReference = collect(newSeq): 
            for row in text[rows]: row[cols.a]
        let count = notReference.count('O')
        if count==0 or count==notReference.len:
            return
        if dir == Up:
            for i in rows.a..<rows.a+count:
                text[i][cols.a]='O'
            for i in rows.a+count..rows.b:
                text[i][cols.a]='.'
            return
        if dir == Down:
            for i in rows.a..rows.b-count:
                text[i][cols.a]='.'
            for i in rows.b-count+1..rows.b:
                text[i][cols.a]='O'
            return

func getSeparators(input:string): seq[Slice[int]] =
    if '#' notin input:
        return @[0..input.len-1]
    var lower = min(max(0,input.find('.')),max(0,input.find('O')))
    var upper = lower
    while upper<input.len:
        if input[upper]=='#':
            result.add(lower..upper-1)
            lower=upper+1
            while lower<input.len and input[lower]=='#':
                inc lower
                inc upper
        inc upper
    if lower<input.len:
        result.add(lower..upper-1)

proc tiltDirection(text:var seq[string],dir:Direction) =
    if dir in {Left,Right}: #Horizontal
        for i in 0..<text.len:
            for sep in text[i].getSeparators():
                text.tiltSection(i..i,sep,dir)
    if dir in {Up,Down}: #Vertical
        for j in 0..<text[0].len:
            var charColumn = collect(newSeq): 
                for row in text: row[j]
            var column = newStringOfCap(charColumn.len)
            for elem in charColumn:
                column.add(elem)
            for sep in column.getSeparators():
                text.tiltSection(sep,j..j,dir)

func weight(text:seq[string]): int =
    var i = text.len
    for row in text:
        result += i*row.count('O')
        dec i
    

var textMatrix = open("rocks.txt").readAll.split("\n")

# var equalSets = newSeqOfCap[HashSet[string]](textMatrix.len)
var equalSets = newSeqWith(textMatrix.len,initHashSet[string]())

for _ in 0..<1000:
    for dir in Direction:
        textMatrix.tiltDirection(dir)
    echo textMatrix[91]

for _ in 0..<100:
    for dir in Direction:
        textMatrix.tiltDirection(dir)
    for i in 0..<textMatrix.len:
        equalSets[i].incl(textMatrix[i])

for i in 0..<textMatrix.len:
    echo i," ",equalSets[i].len