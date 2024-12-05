import Foundation
import Shared

enum Oper : String {
    case Add = "+"
    case Mul = "*"
}

var sum = 0;
FileLines(file: "file:///opt/TestFiles/Test.txt", omittingEmptyLines: true)
    .forEach({
        let split = $0.split(separator: ":");
        let expected = Int(String(split[0]))!;
        let numbers = split[1].split(separator: " ")
            .map({
                Int(String($0))!
            });
        
        var allOperators : [Oper] = [ .Add, .Mul ]
        let operators : [Oper] = Array(repeating: .Add , count: numbers.count - 1);
        var operCombinations = Results<Oper>();
        getOpers(items: operators, 0, allOperators: &allOperators, results: &operCombinations);
        var isPossible = false;
        for combination in operCombinations.arr {
            var result = numbers[0];
            for i in 1..<numbers.count {
                switch combination[i - 1] {
                case .Add:
                    result = result + numbers[i];
                    break;
                case .Mul:
                    result = result * numbers[i];
                    break;
                }
            }
            if result == expected {
                isPossible = true;
                break
            }
        }
        if isPossible {
            sum += expected
        }
    })
print(sum);

class Results<T> {
    public var arr : [[T]] = []
}

func getOpers<T>(items: [T], _ index: Int, allOperators: inout [T], results: inout Results<T>) {
    if index >= items.count {
        results.arr.append(items)
    } else {
        let items = items;
        for op in allOperators {
            var caseArr = items;
            caseArr[index] = op;
            getOpers(items: caseArr, index + 1, allOperators: &allOperators, results: &results)
        }
    }
}
