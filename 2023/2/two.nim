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

proc updateMin(min:var RGB, roll:RGB) =
    for i in 0..2:
        if min[i]<roll[i]:
            min[i]=roll[i]

let file = open("cubes.txt")
var sum = 0
for line in file.lines:
    var game = strToGame(line.split(":")[1])
    var min : RGB = [0,0,0]
    for roll in game:
        min.updateMin(roll)
    sum += min[0]*min[1]*min[2]
        
echo sum