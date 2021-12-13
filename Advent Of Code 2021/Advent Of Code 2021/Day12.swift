//
//  Day12.swift
//  Advent Of Code 2021
//
//  Created by Bart Kneepken on 13/12/2021.
//

import Foundation

struct Day12 {
    static var part1: Int {
        let inputs = input.components(separatedBy: .newlines).map { line -> (String, String) in
            let components = line.components(separatedBy: "-")
            return (components[0], components[1])
        }
        
        var adjacents: [String: [String]] = [:]
        
        for kvp in inputs {
            adjacents[kvp.0, default: []].append(kvp.1)
            adjacents[kvp.1, default: []].append(kvp.0)
        }
        
        func findAllPaths() -> Set<[String]> {
            var visited: Set<String> = Set()
            var currentPath: [String] = ["start"]
            var paths: Set<[String]> = Set()
            
            dfs(from: "start", to: "end", isVisited: &visited, path: &currentPath)
            
            func dfs(from: String, to: String, isVisited: inout Set<String>, path: inout [String]) {
                
                if from == to {
                    paths.insert(path)
                    return
                }
                
                if from.lowercased() == from {
                    isVisited.insert(from)
                }
                
                let children = adjacents[from]
                
                children?.forEach({ child in
                    if !isVisited.contains(child) {

                        path.append(child)
                        dfs(from: child, to: to, isVisited: &isVisited, path: &path)
                        path.removeLast()
                    }
                })
                
                isVisited.remove(from)
                
            }
            
            return paths
        }
        
        return findAllPaths().count
    }
    
    static var part2: Int {
        let inputs = input.components(separatedBy: .newlines).map { line -> (String, String) in
            let components = line.components(separatedBy: "-")
            return (components[0], components[1])
        }
        
        var adjacents: [String: [String]] = [:]
        
        for kvp in inputs {
            adjacents[kvp.0, default: []].append(kvp.1)
            adjacents[kvp.1, default: []].append(kvp.0)
        }
        
        func findAllPaths() -> Set<[String]> {
            var paths: Set<[String]> = Set()
            
            func dfs(from: String, to: String, path: [String], didTwice: Bool, isVisited: [String: Int] = [:]) {
                
                if from == to {
                    paths.insert(path)
                    return
                }
                
                var visited = isVisited
                
                if from.lowercased() == from {
                    visited[from, default: 0] += 1
                }
                
                let children = adjacents[from]
                
                children?.forEach({ child in
                    var newPath = path
                    newPath.append(child)
                    
                    if isVisited[child] == nil {
                        dfs(from: child, to: to, path: newPath, didTwice: didTwice, isVisited: visited)
                    } else if isVisited[child] == 1 && !didTwice && child != "start" {
                        dfs(from: child, to: to, path: newPath, didTwice: true, isVisited: visited)
                    }
                })
                
            }
            
            dfs(from: "start", to: "end", path: ["start"], didTwice: false)
            
            return paths
        }
        
        return findAllPaths().count
    }
}

fileprivate let shortInput = """
dc-end
HN-start
start-kj
dc-start
dc-HN
LN-dc
HN-end
kj-sa
kj-HN
kj-dc
"""

fileprivate let input = """
RT-start
bp-sq
em-bp
end-em
to-MW
to-VK
RT-bp
start-MW
to-hr
sq-AR
RT-hr
bp-to
hr-VK
st-VK
sq-end
MW-sq
to-RT
em-er
bp-hr
MW-em
st-bp
to-start
em-st
st-end
VK-sq
hr-st
"""

