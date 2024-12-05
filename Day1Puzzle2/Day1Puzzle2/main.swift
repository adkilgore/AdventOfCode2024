import Foundation
import Shared

var list1 : [Int] = [];
var list2 : [Int] = [];
FileLineItems(file: "file:///opt/TestFiles/Test.txt")
    .forEach({
        list1.append(Int($0[0])!);
        list2.append(Int($0[1])!);
    });
var sum : Int =
    list1.map({ i in
        i * list2.count(where: {
            l2i in l2i == i
        })
    }).reduce(0, { $0 + $1 });
print(sum);
