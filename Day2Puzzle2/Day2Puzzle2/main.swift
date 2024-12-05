import Foundation
import Shared

var reports = Array(FileLineItems(file: "file:///opt/TestFiles/Test.txt")
    .map({
        Array(
            $0.map({ Int($0)! })
        )
    }));

var safe : [Bool] = [Bool](repeating: false, count: reports.count);

for reportNum in 0..<reports.count {
    let report = reports[reportNum]
    for removeAt in 0..<report.count {
        var testReport = report;
        testReport.remove(at: removeAt)
        var differences : [Int] = []
        for i in 1..<testReport.count {
            differences.append(testReport[i] - testReport[i-1])
        }
        let allIncOrDec = differences.allSatisfy({ $0 > 0 }) || differences.allSatisfy({ $0 < 0 });
        let differByAtLeastOneAndMostThree = differences.allSatisfy({ abs($0) >= 1 && abs($0) <= 3});
        if(allIncOrDec && differByAtLeastOneAndMostThree) {
            safe[reportNum] = true;
        }
    }
}
print(safe.filter({ $0 == true }).count);
