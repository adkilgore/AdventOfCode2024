public struct CoordinateAndDirection : Equatable, Hashable {
    let coordinate: Coordinate
    let direction: Direction
    init(coordinate: Coordinate, direction: Direction) {
        self.coordinate = coordinate;
        self.direction = direction;
    }
}
