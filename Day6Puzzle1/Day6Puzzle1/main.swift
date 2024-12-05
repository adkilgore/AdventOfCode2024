import Foundation
import Shared

func getGuardDirection(char: String) -> Direction? {
    switch char {
    case ">":
        return .right;
    case "<":
        return .left;
    case "v":
        return .down;
    case "^":
        return .up;
    default:
        return nil;
    }
}

var map : [[String]] = []
FileLineChars(file:"file:///opt/TestFiles/Test.txt")
    .forEach({
        var chars : [String] = [];
        $0.forEach({
            chars.append($0)
        })
        map.append(chars);
    })

var sizeX = map[0].count;
var sizeY = map.count;
var posAndDirectionOfGuard = Coordinate.allFlat(sizeX: sizeX, sizeY: sizeY)
    .filter({ c in
        let char = c.get(map);
        return getGuardDirection(char: char) != nil
    })
    .map({ c in
        let guardDirection = getGuardDirection(char: c.get(map));
        return (gPos: c, gDirection: guardDirection)
    })[0]
var pos = posAndDirectionOfGuard.gPos
var direction = posAndDirectionOfGuard.gDirection!

var done = false;
while(!done) {
    for c in pos.walk(direction: direction, includeStart: true){
        let reachedEnd = !c.translate(d: direction, count: 1).isInBounds(sizeX: sizeX, sizeY: sizeY);
        let hitObject = reachedEnd ? false : c.translate(d: direction, count: 1).get(map) == "#";
        map[c.y][c.x] = "X";
        if hitObject {
            pos = c
            direction = direction.turn(direction: .right)
            break;
        }
        else if reachedEnd {
            done = true;
            break;
        }
    }
}

var uniqueVisited = 0;
map.forEach({
        $0.forEach({
            if $0 == "X" {
                uniqueVisited += 1;
            }
        })
    })
print(uniqueVisited);
