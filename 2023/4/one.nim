import strutils,math

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

proc checkScore(card:Card): int =
    let intersect = card[0]*card[1]
    if intersect.card==0:
        return 0
    else:
        return 2^(intersect.card-1)

let file = open("cards.txt")
var sum = 0
for line in file.lines:
    sum += checkScore(line.strToCard)

echo sum