import Foundation;

public class FileLineChars : Sequence {
    let file : String;
    let separator : Character;
    
    public init(file:String, separator:Character) {
        self.file = file;
        self.separator = separator;
    }
    
    public init(file:String) {
        self.file = file;
        self.separator = Character(" ");
    }
    
    public func makeIterator() -> FileLineCharsIterator {
        return FileLineCharsIterator(parent: self);
    }
    
    public class FileLineCharsIterator : IteratorProtocol {
        var lineIter : FileLines.FileLinesIterator;
        var numIterated : Int;
        
        public init(parent: FileLineChars) {
            self.lineIter = FileLines(file: parent.file, omittingEmptyLines: true).makeIterator();
            self.numIterated = 0;
        }
        
        public func next() -> [String]? {
            if let next : String = lineIter.next() {
                var lineItems = next
                    .unicodeScalars
                    .map({ String($0) } );
                numIterated += 1;
                return Array(lineItems);
            }
            return nil;
        }
    }
}

