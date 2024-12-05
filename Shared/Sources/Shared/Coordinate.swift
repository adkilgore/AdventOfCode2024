public struct Coordinate : Equatable, Hashable {
    public let x: Int;
    public let y: Int;
    
    public init(x: Int, y: Int) {
        self.x = x;
        self.y = y;
    }
    
    public func translate(d: Direction, count: Int) -> Coordinate {
        return Coordinate(x: self.x + (d.dx * count),
                          y: self.y + (d.dy * count))
    }
    
    public func translate(dx: Int, dy: Int) -> Coordinate {
        return Coordinate(x: self.x + dx,
                          y: self.y + dy)
    }
    
    public func walk(direction: Direction, includeStart: Bool) -> WalkSequence {
        return WalkSequence(start: self, direction: direction, includeStart: includeStart);
    }
    
    public func isInBounds(sizeX: Int, sizeY: Int) -> Bool {
        return x >= 0 && y >= 0 && x < sizeX && y < sizeY;
    }
    
    public func get(_ arr: [[String]]) -> String {
        return arr[y][x];
    }
    
    public static func allFlat(sizeX: Int, sizeY: Int) -> [Coordinate]{
        var coordinates : [Coordinate] = []
        for i in 0..<sizeX {
            for j in 0..<sizeY {
                coordinates.append(Coordinate(x: i, y: j));
            }
        }
        return coordinates;
    }

    public func getTranslation(other : Coordinate) -> (dx: Int, dy: Int){
        return (dx:  other.x - x, dy: other.y - y)
    }
    
    public static func all(sizeX: Int, sizeY: Int) -> [[Coordinate]]{
        var coordinates : [[Coordinate]] = []
        for i in 0..<sizeX {
            var row : [Coordinate] = []
            for j in 0..<sizeY {
                row.append(Coordinate(x: i, y: j));
            }
            coordinates.append(row);
        }
        return coordinates;
    }
    
    public class WalkSequence : Sequence {
        let start: Coordinate;
        let direction: Direction;
        let includeStart: Bool;
        init(start: Coordinate, direction: Direction, includeStart: Bool) {
            self.start = start;
            self.direction = direction;
            self.includeStart = includeStart;
        }
        
        public func makeIterator() -> some WalkIterator {
            return WalkIterator(sequence: self);
        }
        public class WalkIterator : IteratorProtocol {
            var walked = 0;
            let sequence : WalkSequence;
            
            init(sequence: WalkSequence) {
                self.walked = sequence.includeStart ? -1 : 0;
                self.sequence = sequence;
            }
            
            public func next() -> Coordinate? {
                walked += 1
                return sequence.start.translate(d: sequence.direction, count: walked)
            }
        }
    }
}
