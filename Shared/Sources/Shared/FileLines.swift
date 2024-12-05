import Foundation

public class FileLines : Sequence {
    var file : String;
    
    public init(file: String) {
        self.file = file;
    }
    
    public func makeIterator() -> FileLinesIterator {
        return FileLinesIterator(file: self.file);
    }
    
    public class FileLinesIterator : IteratorProtocol {
        var lines : [String.SubSequence];
        var numIterated : Int;
        
        public init(file:String) {
            do {
                let contents = try String(contentsOf: URL(string: file)!);
                lines = contents.split(separator:"\n");
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
