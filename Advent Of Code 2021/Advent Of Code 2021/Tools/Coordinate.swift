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
    
    var description: String {
        "\(x),\(y)"
    }
}
