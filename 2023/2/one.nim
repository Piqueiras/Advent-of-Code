import strutils

type RGB = array[3, int]

proc strToRGB(str:string): RGB =
    result = [0,0,0]
    for cube in str.split(","):
        var colors = cube.strip.split(" ")
        for i,color in @["red","green","blue"]:
            if color in colors[1]:
                result[i]=colors[0].strip.parseInt

type Game = seq[RGB]

proc strToGame(str:string): Game =
    for roll in str.split(";"):
        result.add(roll.strToRGB)

proc isGamePossible(game:Game, max:RGB): bool =
    for roll in game:
        for i in 0..2:
            if roll[i]>max[i]:
                return false
    return true

let file = open("cubes.txt")
let max : RGB = [12,13,14]
var sum = 0
var i = 1
for line in file.lines:
    var game = strToGame(line.split(":")[1])
    echo game
    if game.isGamePossible(max):
        sum += i
    inc i

echo sum