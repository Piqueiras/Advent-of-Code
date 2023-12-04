import strutils, sequtils, deques

type Number = uint8

type Numbers = set[Number]

type Card = array[2,Numbers]

proc strToCard(input:string): Card =
    var line = input.split(":")[1]
    var i = 0
    for numbers in line.split("|"):
        for number in numbers.split(" "):
            if number.len!=0:
                result[i].incl(Number(number.parseInt))
        inc i

proc checkScore(card:Card): int = card(card[0]*card[1])

let textMatrix = open("cards.txt").readAll.splitLines

var table : array[211,int]
for i in 0..210:
    table[i]=checkScore(textMatrix[i].strToCard)

var cardsToDo = toDeque(toSeq(1..211))

var count = 0
while cardsToDo.len>0:
    inc count
    var current = cardsToDo.popFirst()
    var score = table[current-1]
    for i in countup(current+1,current+score):
        cardsToDo.addLast(i)

echo count