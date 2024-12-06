import sequtils, strutils

proc analyzeReport(report : seq[int]): bool =
    let n = report.len()
    var a = report[0]
    var b = report[1]
    var up : bool
    if b-a <= 3 and b-a >= 1:
        up = true
    elif a-b <= 3 and a-b >= 1:
        up = false
    else:
        return false

    for i in 2..n-1:
        a = b
        b = report[i]
        if up:
            if b-a > 3 or b-a < 1:
                return false
        else:
            if a-b > 3 or a-b < 1:
                return false
    return true

let file = open("reports.txt")
var suma = 0

for line in file.lines:
    var report = line.split(" ").map(parseInt)
    if analyzeReport(report):
        inc suma

echo suma

