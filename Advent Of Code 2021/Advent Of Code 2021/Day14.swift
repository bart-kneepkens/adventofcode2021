//
//  Day14.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepkens on 15/12/2021.
//

import Foundation

struct Day14 {
    static var input = fullInput
    
    static let template = input.components(separatedBy: "\n\n")[0]
    static let rules = input.components(separatedBy: "\n\n")[1].components(separatedBy: .newlines).map { line -> (String, String) in
        let components = line.components(separatedBy: " -> ")
        return (components[0], components[1])
    }
    
    /// Gives results of a single rule, for example CH -> B becomes two pairs, CB and BH
    static func split(rule: (String, String)) ->  (String, String) {
        ("\(rule.0.first!)\(rule.1)", "\(rule.1)\(rule.0.last!)")
    }
    
    static func step(_ frequencies: [String: Int]) -> [String: Int] {
        var returnable = [String: Int]()
        
        for kvp in frequencies {
            let rule = rules.first(where: { $0.0 == kvp.key })!
            let result = split(rule: rule)
            
            returnable[result.0, default: 0] += kvp.value
            returnable[result.1, default: 0] += kvp.value
        }
        
        return returnable
    }
    
    static func setupFrequencyTable(using template: String) -> [String: Int] {
        var frequencies: [String: Int] = [:]
        
        let templateArray = Array(template)
        
        for i in 0..<templateArray.count - 1 {
            frequencies[String(templateArray[i...i+1]), default: 0] += 1
        }
        
        return frequencies
    }
    
    static var part1: Int {
        
        var pairFrequencies = setupFrequencyTable(using: template)
        
        10.times {
            pairFrequencies = step(pairFrequencies)
        }
        
        var counts = [String.Element: Int]()
        
        for pair in pairFrequencies {
            counts[pair.key.first!, default: 0] += pair.value
        }
        
        let minCount = counts.values.min()!
        let maxCount = counts.values.max()!
        
        return maxCount - minCount + 1 // + 1 to compensate for the ending pair
    }
    
    static var part2: Int {
        
        var pairFrequencies = setupFrequencyTable(using: template)
        
        40.times {
            pairFrequencies = step(pairFrequencies)
        }
        
        var counts = [String.Element: Int]()
        
        for pair in pairFrequencies {
            counts[pair.key.first!, default: 0] += pair.value
        }
        
        let minCount = counts.values.min()!
        let maxCount = counts.values.max()!
        
        return maxCount - minCount + 1 // + 1 to compensate for the ending pair
    }
}

// IDK I don't like this day, I have to do something nice
extension Int {
    func times(_ closure: () -> Void) {
        (0..<self).forEach { _ in
            closure()
        }
    }
}

fileprivate let shortInput = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
"""

fileprivate let fullInput = """
SNPVPFCPPKSBNSPSPSOF

CF -> N
NK -> B
SF -> B
HV -> P
FN -> S
VV -> F
FO -> F
VN -> V
PV -> P
FF -> P
ON -> S
PB -> S
PK -> P
OO -> P
SP -> F
VF -> H
OV -> C
BN -> P
OH -> H
NC -> F
BH -> N
CS -> C
BC -> N
OF -> N
SN -> B
FP -> F
FV -> K
HP -> H
VB -> P
FH -> F
HF -> P
BB -> O
HH -> S
PC -> O
PP -> B
VS -> B
HC -> H
NS -> N
KF -> S
BO -> V
NP -> S
NF -> K
BS -> O
KK -> O
VC -> V
KP -> K
CK -> P
HN -> F
KN -> H
KH -> N
SB -> S
NO -> K
HK -> H
BF -> V
SV -> B
CV -> P
CO -> P
FC -> O
CP -> H
CC -> N
CN -> P
SK -> V
SS -> V
VH -> B
OS -> N
FB -> H
NB -> N
SC -> K
NV -> H
HO -> S
SO -> P
PH -> C
VO -> O
OB -> O
FK -> S
PN -> P
VK -> O
NH -> N
OC -> B
BP -> O
PF -> F
KB -> K
KV -> B
PO -> N
NN -> K
CH -> O
KC -> P
OP -> V
VP -> F
OK -> P
FS -> K
CB -> S
HB -> N
KS -> O
BK -> C
BV -> O
SH -> H
PS -> N
HS -> K
KO -> N
"""
