import strutils, algorithm, sequtils

var lista1 : seq[int]
var lista2 : seq[int]

let file = open("lists.txt")
for line in file.lines:
    var datos = line.split("   ")
    lista1.add(parseInt(datos[0]))
    lista2.add(parseInt(datos[1]))

lista1.sort()
lista2.sort()

var suma = 0

for item in zip(lista1,lista2):
    suma += abs(item[0]-item[1])

echo suma