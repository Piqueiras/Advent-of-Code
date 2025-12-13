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
        for j in 0..<MAX:
            if not (conn[i][j] or conn[j][i]) and dists[i][j] < minVal:
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

var distances : Matrix[float]
var connected : Matrix[bool]

for i in 0..<MAX:
    for j in 0..<MAX:
        if i == j:
            distances[i][j] = 0.0
            connected[i][j] = true
        else:
            distances[i][j] = distance(boxes[i], boxes[j])
            connected[i][j] = false

for _ in 1..1000:
    let (a,b) = closestNotConnected(distances, connected)
    connected[a][b] = true
    connected[b][a] = true

for i in 0..<MAX:
    for j in 0..<MAX:
        for k in 0..<MAX:
            if connected[i][j] and (connected[i][k] or connected[j][k]):
                connected[i][k] = true
                connected[k][i] = true
                connected[j][k] = true
                connected[k][j] = true
        


var visited : array[MAX, bool]
var circuits = newSeq[seq[int]]()

for i in 0..<MAX:
    if not visited[i]:
        var circuit = newSeq[int]()
        circuit.add(i)
        for j in i+1..<MAX:
            if connected[i][j]:
                visited[j] = true
                circuit.add(j)
        circuits.add(circuit)

let lens = circuits.mapIt(it.len).sorted()

echo lens[^1] * lens[^2] * lens[^3]