import Foundation
import Shared

var list1 : [Int] = [];
var list2 : [Int] = [];
FileLineItems(file: "file:///opt/TestFiles/Test.txt", separator:" ")
    .forEach({
        list1.append(Int($0[0])!);
        list2.append(Int($0[1])!);
    });
list1.sort();
list2.sort();
var sum = 0;
for i in 0..<list1.count {
    sum += abs(list1[i] - list2[i]);
}
print(sum);
