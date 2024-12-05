import Foundation
import Shared

var chars : [[String]] = []
FileLineChars(file: "File:///opt/TestFiles/Test.txt")
    .forEach({ line in
        var lineArr : [String] = []
        line.forEach({ char in
            lineArr.append(char);
        })
        chars.append(lineArr);
    })

let sizeX = chars[0].count;
let sizeY = chars.count;
var count = 0;
var upLeft = Direction.combine(d1: Direction.up, d2: Direction.left)
var downRight = Direction.combine(d1: Direction.down, d2: Direction.right)

var downLeft = Direction.combine(d1: Direction.down, d2: Direction.left)
var upRight = Direction.combine(d1: Direction.up, d2: Direction.right)

Coordinate.all(sizeX: sizeX - 1,sizeY: sizeY - 1)
    .forEach({
        $0.filter({ $0.x != 0 && $0.y != 0 })
            .forEach({ coord in
                if coord.get(arr: chars) == "A" && checkX(coord: coord) {
                    count += 1
                }
        })
    })

func checkX(coord: Coordinate) -> Bool {
    let upLeftCh = coord.translate(d: upLeft, count: 1).get(arr: chars);
    let downRightCh = coord.translate(d: downRight, count: 1).get(arr: chars);
    
    let downLeftCh = coord.translate(d: downLeft, count: 1).get(arr: chars);
    let upRightCh = coord.translate(d: upRight, count: 1).get(arr: chars);
    
    return ((upLeftCh == "M" && downRightCh == "S") || (upLeftCh == "S" && downRightCh == "M")) &&
           ((downLeftCh == "M" && upRightCh == "S") || (downLeftCh == "S" && upRightCh == "M"))
}

print(count)

