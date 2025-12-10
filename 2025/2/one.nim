import std/[strutils, sequtils, math]

func pow10(n: int): int =
  var r = 1
  for _ in 0..<n:
    r *= 10
  return r

func digitos(n: int): int = n.intToStr.len

func repetidosEntre(a, b: int): seq[int] =
    let da = digitos(a)
    let db = digitos(b)

    if da == db:
        if da mod 2 == 1:
            return @[]
        else:
            result = @[]
            let d = da div 2 
            let m = pow10(d)

            let a1 = a div m
            let a2 = a mod m
            let b1 = b div m
            let b2 = b mod m

            if a1 >= a2 and (a1 != b1 or b2 >= a1):
                result.add(a1*m + a1)
            for i in (a1+1)..(b1-1):
                result.add(i*m + i)
            if b1<=b2 and b1!=a1:
                result.add(b1*m + b1)

    else:
        if da mod 2 == 0:
            result = repetidosEntre(a, pow10(da) - 1)
        elif db mod 2 == 0:
            result = repetidosEntre(pow10(db-1), b)
        else:
            result = @[]


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
    for n in repetidosEntre(a, b):
        suma += n

echo suma