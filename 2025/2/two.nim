import std/[strutils, sequtils, math]

func pow10(n: int): int =
  var r = 1
  for _ in 0..<n:
    r *= 10
  return r

func digitos(n: int): int = n.intToStr.len

func repetidosEntre(a, b, n: int): seq[int] =
    result = @[]
    let da = digitos(a)
    let db = digitos(b)

    if da == db:
        if da mod n != 0:
            return @[]
        else:
            let d = da div n #Se puede dividir porque `da mod n == 0`
            let m = pow10(d)

            var partesA: seq[int] = @[]
            var partesB: seq[int] = @[]
            var tempA = a
            var tempB = b

            for _ in 0..<n:
                partesA.add(tempA mod m)
                tempA = tempA div m
                partesB.add(tempB mod m)
                tempB = tempB div m

            #Por ejemplo, si tenemos n=3 y a=123456789, partesA = [789, 456, 123]

            let numA = parseInt(partesA[^1].intToStr.repeat(n)) #Jurao estuve 2 horas con no se que flag
            if numA >= a and numA <= b:
                result.add(numA)
                
            for i in (partesA[^1] + 1)..(partesB[^1] - 1):
                result.add(parseInt(i.intToStr.repeat(n)))

            let numB = parseInt(partesB[^1].intToStr.repeat(n))
            if numB >= a and numB <= b and numB notin result:
                result.add(numB)

    else:
        result = repetidosEntre(a, pow10(da) - 1, n) & repetidosEntre(pow10(db-1), b, n)


let file = open("ranges.txt")
let line = file.readLine()
file.close()

var ranges: seq[(int, int)] = @[]

for part in line.split(','):
    let bounds = part.split('-')
    if bounds.len == 2:
        let a = parseInt(bounds[0])
        let b = parseInt(bounds[1])
        ranges.add((a, b))

var suma = 0

for pair in ranges:
    let (a, b) = pair
    var repetidos: seq[int] = @[]
    for i in 2..40:
        for n in repetidosEntre(a, b, i):
            if n notin repetidos:
                repetidos.add(n)
                suma += n
echo "4174379265"
echo suma