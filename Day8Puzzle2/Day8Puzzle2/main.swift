import Foundation
import Shared

struct Antenna : Equatable , Hashable {
    var Coordinate : Coordinate;
    var Kind : String;
    
    init(coordinate: Coordinate, kind: String){
        self.Coordinate = coordinate;
        self.Kind = kind;
    }
}

var board : [[String]] = []
FileLines(file: "file:///opt/TestFiles/Test.txt", omittingEmptyLines: true)
    .forEach({ l in
        var lnChars : [String] = []
        l.forEach({
            lnChars.append(String($0))
        })
        board.append(lnChars)
    })

var antennas : Set<Antenna> = Set<Antenna>();
let sizeX = board[0].count
let sizeY = board.count
Coordinate.all(sizeX: sizeX, sizeY: sizeY)
    .forEach({
        $0.filter({ coord in
            let c = Character(coord.get(arr: board))
            return c.isNumber || c.isLetter;
        })
        .forEach({ coord in
            let kind = coord.get(arr: board);
            antennas.insert(Antenna(coordinate: coord, kind: kind))
        })
    })
    
var found : Set<Coordinate> = Set<Coordinate>();
antennas.forEach({ a in
    antennas.filter({ a2 in
        return a != a2 && a.Kind == a2.Kind
    })
    .forEach({ a2 in
        let translation = a.Coordinate.getTranslation(other: a2.Coordinate);
        let reverseTranslation = (dx: translation.dx * -1, dy: translation.dy * -1)
        
        var potential = a.Coordinate.translate(dx: reverseTranslation.dx, dy: reverseTranslation.dy)
        while potential.isInBounds(sizeX: sizeX, sizeY: sizeY) {
            found.insert(potential)
            potential = potential.translate(dx: reverseTranslation.dx, dy: reverseTranslation.dy)
        }
        found.insert(a.Coordinate)
    })
})
print(found.count)

