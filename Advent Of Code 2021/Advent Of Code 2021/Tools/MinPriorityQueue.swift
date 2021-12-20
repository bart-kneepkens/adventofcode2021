//
//  MinPriorityQueue.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepkens on 20/12/2021.
//

import Foundation

// TODO: Change the underlying data type for something faster, perhaps a min heap
class MinPriorityQueue<T: Hashable> {
    private var dict: [Int: Set<T>] = [:]
    
    func insert(item: T, priority: Int) {
        dict[priority, default: Set<T>()].insert(item)
    }
    
    func updateKey(item: T, to priority: Int) {
        guard let key = dict.first(where: { $0.value.contains(item) })?.key, let values = dict[key] else { return }
        
        if values.count == 1 {
            dict[key] = nil
        } else {
            dict[key] = values.filter({ $0 != item })
        }
        
        dict[priority, default: Set<T>()].insert(item)
    }
    
    func take() -> T? {
        guard let minPriority = dict.keys.min(), let items = dict[minPriority] else {
            return nil
        }
        
        guard !items.isEmpty else { return nil }
        
        let item = items.first!
        
        if items.count == 1 {
            dict[minPriority] = nil
        } else {
            dict[minPriority] = items.filter({ $0 != item })
        }
        
        return item
    }
}
