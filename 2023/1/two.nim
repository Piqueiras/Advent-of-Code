import strutils

const numbers = {"0":"zero","1":"one", "2":"two", "3":"three", "4":"four", "5":"five", "6":"six", "7":"seven", "8":"eight", "9":"nine"}

var totalsum=0

let file = open("trebuchet.txt")
for line in file.lines:
    var varline = line
    block checkline:
        while true:
            echo varline
            for i in 1..9:
                if varline.startsWith(numbers[i][1]) or varline.startsWith(numbers[i][0]):
                    echo i
                    totalsum += 10*i
                    break checkline
            varline = varline[1..^1]
    varline = line
    block checkline:
        while true:
            echo varline
            for i in 1..9:
                if varline.endsWith(numbers[i][1]) or varline.endsWith(numbers[i][0]):
                    echo i
                    totalsum += i
                    break checkline
            varline = varline[0..^2]

echo totalsum
close(file)