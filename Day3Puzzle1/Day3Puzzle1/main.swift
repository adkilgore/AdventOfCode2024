//
//  main.swift
//  Day3Puzzle1
//

import Foundation;
import Shared;

let search = /mul\((?<left>\d{1,3}),(?<right>\d{1,3})\)/
var sum = 0;
FileLines(file: "file:///opt/TestFiles/Test.txt")
    .forEach({ line in
        line.matches(of: search)
            .forEach({ match in
                sum = (sum +
                   (Int(match.left))! *
                    Int(match.right)!)
            })
    })
print(sum);
