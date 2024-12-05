import Foundation

public class FileLines : Sequence {
    var file : String;
    var omittingEmptyLines : Bool;
    
    public init(file: String, omittingEmptyLines: Bool) {
        self.file = file;
        self.omittingEmptyLines = omittingEmptyLines;
    }
    
    public init(file: String) {
        self.file = file;
        self.omittingEmptyLines = false;
    }
    
    public func makeIterator() -> FileLinesIterator {
        return FileLinesIterator(file: self.file, omittingEmptyLines: self.omittingEmptyLines);
    }
    
    public class FileLinesIterator : IteratorProtocol {
        var lines : [String.SubSequence];
        var numIterated : Int;
        
        public init(file:String, omittingEmptyLines: Bool) {
            do {
                let contents = try String(contentsOf: URL(string: file)!);
                lines = contents.split(separator:"\n", omittingEmptySubsequences: omittingEmptyLines);
                numIterated = 0;
            }
            catch {
                fatalError("Could not open file: \(error)");
            }
        }
        
        public func next() -> String? {
            if numIterated < lines.count {
                var itemNum = numIterated;
                numIterated += 1;
                return String(lines[itemNum]);
            }
            return nil;
        }
    }
}
