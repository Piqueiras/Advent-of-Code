import strutils, sequtils

var lista1 : seq[int]
var lista2 : seq[int]

let file = open("lists.txt")
for line in file.lines:
    var datos = line.split("   ")
    lista1.add(parseInt(datos[0]))
    lista2.add(parseInt(datos[1]))

var suma = 0

for item in lista1:
    suma += item * lista2.count(item)

echo suma