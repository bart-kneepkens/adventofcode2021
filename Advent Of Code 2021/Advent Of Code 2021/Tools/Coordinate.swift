//
//  Coordinate.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepkens on 20/12/2021.
//

import Foundation

struct Coordinate: Hashable, CustomStringConvertible {
    let x: Int
    let y: Int
    
    var description: String {
        "\(x),\(y)"
    }
    
    func fits(in size: Int) -> Bool {
        x >= 0 && x < size && y >= 0 && y < size
    }
}

extension Coordinate {
    var leftNeighbor: Coordinate {
        Coordinate(x: x - 1, y: y)
    }
    
    var rightNeighbor: Coordinate {
        Coordinate(x: x + 1, y: y)
    }
    
    var bottomNeighbor: Coordinate {
        Coordinate(x: x, y: y - 1)
    }
    
    var topNeighbor: Coordinate {
        Coordinate(x: x, y: y + 1)
    }
    
    var nearestNeighbors: Set<Coordinate> {
        Set([leftNeighbor, rightNeighbor, bottomNeighbor, topNeighbor])
    }
    
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
