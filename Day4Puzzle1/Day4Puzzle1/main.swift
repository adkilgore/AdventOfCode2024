import Foundation
import Shared

var chars : [[String]] = []
FileLineItems(file: "file:///opt/TestFiles/Test.txt")
    .forEach({
        var seq : [String] = [];
        $0.forEach({
            seq.append($0)
        })
        chars.append(seq);
    });

let sizeX = chars[0].count;
let sizeY = chars.count;
var count = 0;
Coordinate.all(sizeX: sizeX,sizeY: sizeY)
    .forEach({ lineCoords in
        lineCoords.forEach({ coord in
            Direction.all().forEach({ direction in
                let str = coord.walk(direction: direction, includeStart: true)
                    .prefix(while: { $0.isInBounds(sizeX: sizeX, sizeY: sizeY) })
                    .prefix(4)
                    .map({ $0.get(arr: chars) })
                    .reduce("", { $0 + $1 })
                if str == "XMAS" {
                    count += 1;
                }
            })
        })
    })
print(count)
