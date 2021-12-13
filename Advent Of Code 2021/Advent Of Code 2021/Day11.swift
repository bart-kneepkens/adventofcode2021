//
//  Day11.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepken on 12/12/2021.
//

import Foundation

extension Coordinate {
    var topLeftNeighbor: Coordinate {
        Coordinate(x: x - 1, y: y + 1)
    }
    
    var topRightNeighbor: Coordinate {
        Coordinate(x: x + 1, y: y + 1)
    }
    
    var bottomLeftNeighbor: Coordinate {
        Coordinate(x: x - 1, y: y - 1)
    }
    
    var bottomRightNeighbor: Coordinate {
        Coordinate(x: x + 1, y: y - 1)
    }
    
    var neighbors: [Coordinate] {
        [leftNeighbor, topLeftNeighbor, topNeighbor, topRightNeighbor, rightNeighbor, bottomRightNeighbor, bottomNeighbor, bottomLeftNeighbor]
    }
}

struct Day11 {
    
    static private var grid: [[Int]] = input
        .components(separatedBy: .newlines)
        .map({ $0.compactMap({ Int(String($0)) }) })
    
    /// Safely access a value at given coordinate, returns nil if it's out of the collection bounds.
    static func access(at coordinate: Coordinate, in collection: [[Int]]) -> Int? {
        if coordinate.x > -1 && coordinate.y > -1 && coordinate.x < collection[0].count && coordinate.y < collection.count {
            return collection[coordinate.y][coordinate.x]
        }
        return nil
    }
    
    /// Returns coordinates that are affected by flashing the coordinates that are passed.
    /// In other words, its neighbors.
    /// Returns a dictionary where the coordinate is key, and the value is the amount of 'flashing' neighbors it has.
    static func affectedCoordinates(from flashing: Set<Coordinate>) -> [Coordinate: Int] {
        flashing
            .flatMap(\.neighbors)
            .filter({ !flashing.contains($0) })
            .reduce([Coordinate: Int]()) { partialResult, coord in
                var result = partialResult
                result[coord, default: 0] += 1
                return result
            }
    }
    
    /// Basically; find any coordinate where a flash should occur this turn (>9)
    static func findCoordinatesThatShouldFlash(in collection: [[Int]]) -> Set<Coordinate> {
        Set(collection
                .enumerated()
                .flatMap { (yOffset, row) in
            
            row.enumerated()
                .filter({ $0.element > 9 })
                .map({ Coordinate(x: $0.offset, y: yOffset) })}
        )
    }
    
    static func cycle(_ before: [[Int]]) -> ([[Int]], [Coordinate: Int]) {
        var new = before
        var flashCounts: [Coordinate: Int] = [:]
        
        // First, the energy level of each octopus increases by 1.
        new = new.map({ $0.map({ $0 + 1 })})
        
        var coordinatesThatShouldFlash = findCoordinatesThatShouldFlash(in: new)
        
        while !coordinatesThatShouldFlash.isEmpty {
            let affectedCoordinates = affectedCoordinates(from: coordinatesThatShouldFlash)
            
            coordinatesThatShouldFlash.forEach { coordinate in
                new[coordinate.y][coordinate.x] = 0
                flashCounts[coordinate, default: 0] += 1
            }
            
            affectedCoordinates.forEach { (coordinate, frequency) in
                if let value = access(at: coordinate, in: new), flashCounts[coordinate] == nil {
                    new[coordinate.y][coordinate.x] = value + frequency
                }
            }
            
            coordinatesThatShouldFlash = findCoordinatesThatShouldFlash(in: new)
        }
    
        return (new, flashCounts)
    }
    
    static var part1: Int {
        var g = grid
        var flashes: Int = 0
        
        for _ in 0..<100 {
            let result = cycle(g)
            g = result.0
            flashes += result.1.values.reduce(0, +)
        }
      
        return flashes
    }
    
    static var part2: Int {
        var g = grid
        var isSynced = false
        var count = 0
        
        while !isSynced {
            let result = cycle(g)
            g = result.0
            isSynced = Set(result.0.flatMap({ $0 })) == Set([0])
            count += 1
        }
      
        return count
    }
}

fileprivate let shortInput = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

fileprivate let input = """
2238518614
4552388553
2562121143
2666685337
7575518784
3572534871
8411718283
7742668385
1235133231
2546165345
"""

