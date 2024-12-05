public class FileLineItems : Sequence {
    let file : String;
    let separator : Character;
    
    public init(file: String) {
        self.file = file;
        self.separator = " "
    }
    
    public init(file: String, separator: Character) {
        self.file = file;
        self.separator = separator;
    }
    
    public func makeIterator() -> FileLineItemsIterator {
        return FileLineItemsIterator(parent: self);
    }
    
    public class FileLineItemsIterator : IteratorProtocol {
        let lineIter : FileLines.FileLinesIterator;
        let parent : FileLineItems;
        
        var numIterated : Int;
        
        public init(parent: FileLineItems) {
            self.parent = parent;
            self.lineIter = FileLines(file: parent.file).makeIterator();
            self.numIterated = 0;
        }
        
        public func next() -> [String]? {
            if let next : String = lineIter.next() {
                var lineItems = next
                    .split(separator: parent.separator)
                    .map({ String($0) } );
                numIterated += 1;
                return Array(lineItems);
            }
            return nil;
        }
    }
}
