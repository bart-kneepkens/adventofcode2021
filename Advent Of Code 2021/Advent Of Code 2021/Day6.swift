//
//  Day6.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepken on 06/12/2021.
//

import Foundation

struct Day6 {
    static private func ageLanternFish(school: [Int], days: Int) -> Int {
        // Frequency array - index is the age, value is the count of fish of that age
        var frequencies = [Int](repeating: 0, count: 9)
        
        school.forEach { fishWithAge in
            frequencies[fishWithAge] += 1
        }
        
        
        (0..<days).forEach { _ in
            let newFish = frequencies.first!
            frequencies[0] = frequencies[1]
            frequencies[1] = frequencies[2]
            frequencies[2] = frequencies[3]
            frequencies[3] = frequencies[4]
            frequencies[4] = frequencies[5]
            frequencies[5] = frequencies[6]
            frequencies[6] = frequencies[7] + newFish
            frequencies[7] = frequencies[8]
            frequencies[8] = newFish
        }
        
        return frequencies.reduce(0, +)
    }
    
    static var amountOfLanternFishAfter80Days: Int {
        let school = shortInput.components(separatedBy: ",").compactMap({ Int($0) })
        return ageLanternFish(school: school, days: 18)
    }
}

fileprivate let shortInput = """
3,4,3,1,2
"""

fileprivate let input = """
2,5,3,4,4,5,3,2,3,3,2,2,4,2,5,4,1,1,4,4,5,1,2,1,5,2,1,5,1,1,1,2,4,3,3,1,4,2,3,4,5,1,2,5,1,2,2,5,2,4,4,1,4,5,4,2,1,5,5,3,2,1,3,2,1,4,2,5,5,5,2,3,3,5,1,1,5,3,4,2,1,4,4,5,4,5,3,1,4,5,1,5,3,5,4,4,4,1,4,2,2,2,5,4,3,1,4,4,3,4,2,1,1,5,3,3,2,5,3,1,2,2,4,1,4,1,5,1,1,2,5,2,2,5,2,4,4,3,4,1,3,3,5,4,5,4,5,5,5,5,5,4,4,5,3,4,3,3,1,1,5,2,4,5,5,1,5,2,4,5,4,2,4,4,4,2,2,2,2,2,3,5,3,1,1,2,1,1,5,1,4,3,4,2,5,3,4,4,3,5,5,5,4,1,3,4,4,2,2,1,4,1,2,1,2,1,5,5,3,4,1,3,2,1,4,5,1,5,5,1,2,3,4,2,1,4,1,4,2,3,3,2,4,1,4,1,4,4,1,5,3,1,5,2,1,1,2,3,3,2,4,1,2,1,5,1,1,2,1,2,1,2,4,5,3,5,5,1,3,4,1,1,3,3,2,2,4,3,1,1,2,4,1,1,1,5,4,2,4,3
"""
