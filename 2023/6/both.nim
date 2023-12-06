import math
let times = @[46,68,98,66]
let distances = @[358,1054,1807,1080]

#Call t the maximum time and n how long you hold.
#Total distance is given by f defined in {0,..,t} and f_t(n)=n(t-n)
#This is at all times a curved down parabolla with roots on 0 and t
#If R is the record we have to find for how many values in {0,..,t} f_t(n)>R

func weirdAssFormula(N,M:int): int = 
    let a = sqrt(float(N*N-4*M-4))/2
    return 1 + int(floor(N/2 + a)) - int(ceil(N/2 - a))

var mult = 1
for i in 0..3:
    mult *= weirdAssFormula(times[i],distances[i])

echo mult

#Part 2

echo weirdAssFormula(46689866,358105418071080)