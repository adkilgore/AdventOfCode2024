import Foundation;
import Shared;

let search = /(?<doOrDont>do(n't)?)\(\)|mul\((?<left>\d{1,3}),(?<right>\d{1,3})\)/
var sum = 0;
var enabled = true;
FileLines(file: "file:///opt/TestFiles/Test.txt")
    .forEach({ line in
        line.matches(of: search)
            .forEach({ match in
                if match.doOrDont == "do" {
                    enabled = true;
                }
                else if match.doOrDont == "don't" {
                    enabled = false;
                }
                else if enabled {
                    sum = (sum +
                       (Int(match.left!))! *
                        Int(match.right!)!)
                }
            })
    })
print(sum);
