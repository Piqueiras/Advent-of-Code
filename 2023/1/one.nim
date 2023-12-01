import strutils,algorithm

var totalsum=0

let file = open("trebuchet.txt")
for line in file.lines:
    #Find the first number
    for c in line:
        if c.isDigit:
            totalsum += 10 * (int(c) - int('0'))
            break
    #Find the last number
    for c in line.reversed:
        if c.isDigit:
            totalsum += (int(c) - int('0'))
            break

echo totalsum
close(file)