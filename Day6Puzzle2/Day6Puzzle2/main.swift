import Foundation
import Shared

let clock = ContinuousClock()
var elapsed = clock.measure {
    var map: [[String]] = []
    FileLineChars(file:"file:///opt/TestFiles/Test.txt")
        .forEach({
            var chars : [String] = [];
            $0.forEach({
                chars.append($0)
            })
            map.append(chars);
        })
    var placesToTry = Set<Coordinate>()
    run(map).visited.forEach({
        placesToTry.insert($0.coordinate);
    });
    
    var loops = 0;
    for place in placesToTry {
        if place.get(map) != "." {
            continue;
        }
        var testMap = map;
        testMap[place.y][place.x] = "#"
        if run(testMap).looped {
            loops += 1
        }
    }
    print(loops);
    
    
    func run(_ map: [[String]]) -> (looped: Bool, visited: Set<CoordinateAndDirection>) {
        var visited = Set<CoordinateAndDirection>();
        let sizeX = map[0].count;
        let sizeY = map.count;
        let posAndDirectionOfGuard = Coordinate.allFlat(sizeX: sizeX, sizeY: sizeY)
            .filter({ c in
                let char = c.get(map);
                return getGuardDirection(char: char) != nil
            })
            .map({ c in
                let char = c.get(map);
                let guardDirection = getGuardDirection(char: char);
                return (gPos: c, gDirection: guardDirection)
            })[0]
        
        var pos = posAndDirectionOfGuard.gPos
        var direction = posAndDirectionOfGuard.gDirection!
        
        var looped = false;
        var done = false;
        while(!done) {
            for c in pos.walk(direction: direction, includeStart: true){
                let reachedEnd = !c.translate(d: direction, count: 1).isInBounds(sizeX: sizeX, sizeY: sizeY);
                let hitObject = reachedEnd ? false : c.translate(d: direction, count: 1).get(map) == "#";
                let visitedItem = CoordinateAndDirection(coordinate: c, direction: direction);
                let inLoop = reachedEnd ? false : visited.contains(visitedItem);
                visited.insert(visitedItem);
                if hitObject {
                    pos = c
                    direction = direction.turn(direction: .right)
                    break;
                }
                else if reachedEnd {
                    done = true;
                    break;
                }
                else if inLoop {
                    looped = true;
                    done = true;
                    break;
                }
            }
        }
        return (looped: looped, visited: visited)
    }
}
print(elapsed)

