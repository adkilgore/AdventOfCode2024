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
