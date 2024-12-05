public struct Direction : Sendable, Equatable, Hashable {
    public let dx: Int;
    public let dy: Int;
    
    public static let up = Direction(x: 0,y: -1);
    public static let down = Direction(x: 0,y: 1);
    public static let left = Direction(x: -1,y: 0);
    public static let right = Direction(x: 1,y: 0);
    
    init(x: Int, y: Int) {
        self.dx = x;
        self.dy = y;
    }
    
    public func rotateNinetyDegreesClockwise() -> Direction {
        switch self {
        case .up:
            return .right;
        case .right:
            return .down;
        case .down:
            return .left;
        case .left:
            return .up;
        default:
            fatalError();
        }
    }
    
    public func rotateNinetyDegreesCounterClockwise() -> Direction {
        switch self {
        case .up:
            return .left;
        case .left:
            return .down;
        case .down:
            return .right;
        case .right:
            return .up;
        default:
            fatalError();
        }
    }
    
    public func turn(direction: Direction) -> Direction {
        switch direction {
        case .up:
            fatalError("Cannot turn up or down");
        case .down:
            fatalError("Cannot turn up or down");
        case .right:
            return rotateNinetyDegreesClockwise();
        case .left:
            return rotateNinetyDegreesCounterClockwise();
        default:
            fatalError();
        }
    }
    
    public static func combine(d1: Direction, d2: Direction) -> Direction {
        return Direction(x: max(-1, min(1, d1.dx + d2.dx)),
                         y: max(-1, min(1, d1.dy + d2.dy)))
    }
    
    public func reverse() -> Direction {
        return Direction(x: self.dx * -1, y: self.dy * -1);
    }
    
    public static func all() -> [Direction] {
        return [.up, .down, .left,.right,
                .combine(d1: .up,d2: .left),
                .combine(d1: .up,d2: .right),
                .combine(d1: .down,d2: .left),
                .combine(d1: .down,d2: .right)]
    }
}
