import strutils,sequtils,math,algorithm

const MAX = 1000
type Box = tuple[x,y,z: int]
type Matrix[T] = array[MAX, array[MAX, T]]

func distance(a,b:Box): float = 
    sqrt(float((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 + (a.z - b.z) ^ 2))

func closestNotConnected(dists:Matrix[float],conn:Matrix[bool]): tuple[i,j:int] =
    var minVal : float = 999999999
    var minI, minJ = 0
    for i in 0..<MAX:
        for j in i..<MAX:
            if not conn[i][j] and dists[i][j] < minVal:
                minVal = dists[i][j]
                minI = i
                minJ = j
    return (minI, minJ)


let file = open("circuits.txt")

var boxes : array[MAX, Box]
var i = 0

for line in file.lines():
    let parts = line.split(',')
    boxes[i] = (parts[0].parseInt(), parts[1].parseInt(), parts[2].parseInt())
    inc i

# Inicialización

var distances : Matrix[float]
var connected : Matrix[bool]
var clusters : array[MAX, int]

for i in 0..<MAX:
    clusters[i] = i
    for j in i..<MAX:
        if i == j:
            distances[i][j] = 0.0
            connected[i][j] = true
        else:
            distances[i][j] = distance(boxes[i], boxes[j])
            connected[i][j] = false
    
# Recorrido

var a,b:int

while not all(clusters, proc (x: int): bool = x == 0):
    (a,b) = closestNotConnected(distances, connected)
    if a > b:
        swap(a,b) # a siempre es el menor
    
    connected[a][b] = true

    var menor = clusters[a]
    var mayor = clusters[b]
    if menor > mayor:
        swap(menor, mayor)
    
    for i in 0..<MAX:
        if clusters[i] == mayor:
            clusters[i] = menor
    
# Multiplicar los x de las ultimas en unirse

echo boxes[a].x * boxes[b].x