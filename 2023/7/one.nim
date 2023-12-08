import strutils,sequtils,algorithm

type
  Hand = enum
    FiveOfAKind,
    FourOfAKind,
    FullHouse,
    ThreeOfAKind,
    TwoPair,
    OnePair,
    HighCard

type
  Card = tuple
    hand: string
    bet: int

const poker = "AKQJT98765432"

proc compare(a,b:char): int =
    result = cmp(poker.find(a), poker.find(b))

proc compare(a,b:string): int =
    for i in 0..<a.len:
        if compare(a[i],b[i]) != 0:
            return compare(a[i],b[i])
    return 0

proc rank(card:string): Hand =
    for letter in poker:
        var count = card.count(letter)
        if count == 5:
            return FiveOfAKind
        if count == 4:
            return FourOfAKind
        if count == 3:
            for newletter in poker:
                if newletter==letter:
                    continue
                if card.count(newletter) == 2:
                    return FullHouse
            return ThreeOfAKind
    #Leave loop cause might cause trouble if we do some count == 2
    #Here we know there are no 3 equal letters
    for letter in poker:
        if card.count(letter) == 2:
            for newletter in poker:
                if newletter==letter:
                    continue
                if card.count(newletter) == 2:
                    return TwoPair
            return OnePair
    return HighCard

proc compare(a, b: Card): int =
  result = cmp(a.hand.rank, b.hand.rank)
  if result == 0:
    result = compare(a.hand, b.hand)

var cards = newSeqOfCap[Card](1000)

let file = open("camel.txt")
for line in file.lines:
    let split = line.split(" ")
    cards.add((split[0],split[1].parseInt))

cards.sort(compare,SortOrder.Descending)

var sum = 0

for i,elem in cards:
    sum += (i+1)*elem.bet

echo sum