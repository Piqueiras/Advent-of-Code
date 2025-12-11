import strutils

const SIZE = 135

type PaperMap = array[SIZE, array[SIZE, bool]]

proc toPaperMap(path:string): PaperMap =
    let file = open(path)
    for i in 0..<SIZE:
        let line = file.readLine()
        for j in 0..<SIZE:
            result[i][j] = line[j] == '@'
    file.close()

var papers = toPaperMap("papers.txt")

proc rondaEliminarPapeles(papers:var PaperMap): int =
    #Esquinas
    if papers[0][0]:
        inc result
        papers[0][0] = false
    if papers[0][SIZE-1]:
        inc result
        papers[0][SIZE-1] = false
    if papers[SIZE-1][0]:
        inc result
        papers[SIZE-1][0] = false
    if papers[SIZE-1][SIZE-1]:
        inc result
        papers[SIZE-1][SIZE-1] = false

    #Borde superior
    for i in 1..<(SIZE-1):
        if not papers[0][i]:
            continue
        var count = 0

        if papers[0][i-1]:
            inc count
        if papers[0][i+1]:
            inc count
        for k in -1..1:
            if papers[1][i+k]:
                inc count

        if count<4:
            inc result
            papers[0][i] = false

    #Borde inferior
    for i in 1..<(SIZE-1):
        if not papers[SIZE-1][i]:
            continue
        var count = 0

        if papers[SIZE-1][i-1]:
            inc count
        if papers[SIZE-1][i+1]:
            inc count
        for k in -1..1:
            if papers[SIZE-2][i+k]:
                inc count

        if count<4:
            inc result
            papers[SIZE-1][i] = false

    #Borde derecho
    for i in 1..<(SIZE-1):
        if not papers[i][SIZE-1]:
            continue
        var count = 0

        if papers[i-1][SIZE-1]:
            inc count
        if papers[i+1][SIZE-1]:
            inc count
        for k in -1..1:
            if papers[i+k][SIZE-2]:
                inc count

        if count<4:
            inc result
            papers[i][SIZE-1] = false

    #Borde izquierdo
    for i in 1..<(SIZE-1):
        if not papers[i][0]:
            continue
        var count = 0

        if papers[i-1][0]:
            inc count
        if papers[i+1][0]:
            inc count
        for k in -1..1:
            if papers[i+k][1]:
                inc count

        if count<4:
            inc result
            papers[i][0] = false

    #Interior
    for i in 1..<(SIZE-1):
        for j in 1..<(SIZE-1):
            if not papers[i][j]:
                continue
            var count = 0

            for di in -1..1:
                for dj in -1..1:
                    if di == 0 and dj == 0:
                        continue
                    if papers[i+di][j+dj]:
                        inc count

            if count<4:
                inc result
                papers[i][j] = false

var suma = 0
var temp = -1
while temp != 0:
    temp = rondaEliminarPapeles(papers)
    suma += temp

echo suma