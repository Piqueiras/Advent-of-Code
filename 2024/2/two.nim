import sequtils, strutils

proc isReportPerfect(report : seq[int]): bool =
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

proc isReportSafe(report : seq[int]): bool =
    # Goofy ahh
    for i in 0..<report.len():
        var cut = report[0..i-1] & report[i+1..report.len-1]
        if isReportPerfect(cut):
            return true
    return false

let file = open("reports.txt")
var suma = 0

for line in file.lines:
    var report = line.split(" ").map(parseInt)
    if isReportPerfect(report) or isReportSafe(report):
        inc suma

echo suma