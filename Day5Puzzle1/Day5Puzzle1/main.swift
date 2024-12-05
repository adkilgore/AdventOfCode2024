import Foundation
import Shared

var rules : [Rule] = []
var pageSets : [[Int]] = []
var sortedPageSets : [[Int]] = []

FileLines(file: "file:///opt/TestFiles/Test.txt")
    .prefix(while: {
        l in !l.contains(",")
    })
    .forEach({ l in
        let pieces = l.split(separator: "|")
        let rule = Rule(p1: Int(pieces.first!)!,p2: Int(pieces.last!)!)
        rules.append(rule);
    })

var rulesLookup = Dictionary<Int,Set<Int>>();
for rule in rules {
    //for lessThan in expandLess(rule: rule, ruleSet: rules) {
        if !rulesLookup.keys.contains(rule.p1) {
            rulesLookup[rule.p1] = Set<Int>();
        }
        rulesLookup[rule.p1]!.insert(rule.p2);
    //}
}

FileLines(file: "file:///opt/TestFiles/Test.txt")
    .drop(while: { l in l.contains("|") })
    .forEach({ l in
        var pageSet : [Int] = []
        l.split(separator: ",")
            .forEach({ pageSet.append(Int($0)!) })
        pageSets.append(pageSet);
    })

pageSets.forEach({ pageSet in
    var sorted : [Int] = []
    pageSet.forEach({ page in
        var stopRules : Set<Int>;
        if let lookupResult = rulesLookup[page] {
            stopRules = lookupResult;
        }
        else {
            stopRules = Set<Int>();
        }
        var insertAt : Int? = nil;
        for i in 0..<sorted.count {
            if stopRules.contains(sorted[i]) {
                insertAt = i;
                break;
            }
        }
        if let insertAtIndex = insertAt {
            sorted.insert(page, at: insertAtIndex)
        }
        else {
            sorted.append(page)
        }
    })
    sortedPageSets.append(sorted)
})

var sum = 0;
for i in 0..<sortedPageSets.count {
    let unsorted = pageSets[i]
    let sorted = sortedPageSets[i]
    if pageSets[i] != sortedPageSets[i] {
        let middle = (sorted.count / 2);
        let num = sorted[middle];
        print("unsorted:",terminator: "")
        printArr(unsorted)
        print("sorted:",terminator: "")
        printArr(sorted)
        sum += num
    }
}
print(sum);

func printArr(_ arr: [Int]) {
    arr.forEach({
        print($0, terminator: "")
        print(",",terminator: "")
    })
    print("\n", terminator: "");
}

func expandLess(rule: Rule, ruleSet: [Rule]) -> [Int] {
    var ruleLessThan : [Int] = [rule.p2]
    ruleSet
        .filter({ otherRule in otherRule.p1 == rule.p2 })
        .map({ otherRule in expandLess(rule: otherRule, ruleSet: ruleSet) })
        .forEach({
            $0.forEach({
                ruleLessThan.append($0);
            })
        })
    return ruleLessThan;
}
