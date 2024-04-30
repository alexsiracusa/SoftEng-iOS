//
//  Graph.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import Foundation
import SwiftUI
import Algorithms

func > (lhs: (Double, String), rhs: (Double, String)) -> Bool { lhs.0 > rhs.0 }
func < (lhs: (Double, String), rhs: (Double, String)) -> Bool { lhs.0 < rhs.0 }

class PathfindingResult {
    let path: [Node]
    var icons: [PathIcon?]! = nil
    
    let edges: [Edge]
    
    init(path: [Node], edges: [Edge]) {
        self.path = path
        self.edges = edges
        
        // initialize icons
        initializeIcons()
    }
    
    private func initializeIcons() {
        guard path.count > 0 else {
            self.icons = []
            return
        }
        
        guard path.count > 1 else {
            self.icons = [NodeIconData(node: path[0])]
            return
        }
        
        var icons: [PathIcon?] = Array.init(repeating: nil, count: path.count)
        icons[0] = NodeIconData(node: path[0])
        icons[path.count - 1] = NodeIconData(node: path[path.count - 1])
        for index in 1...path.count - 2 {
            let node = path[index]
            let previous = path[index - 1]
            let next = path[index + 1]
            
            if node.floor != next.floor {
                icons[index] = FloorIconData(
                    node: node,
                    floor: next.floor,
                    up: node.floor < next.floor
                )
            }
            else if node.floor != previous.floor {
                icons[index] = FloorIconData(
                    node: node,
                    floor: previous.floor,
                    up: node.floor < previous.floor
                )
            }
        }
        
        self.icons = icons
    }
    
    func displayData(floor: Floor) -> [PathData] {
        var paths = [PathData]()
        
        var path = [Node]()
        var icons = [PathIcon]()
        
        for (node, icon) in zip(self.path, self.icons) {
            if node.floor == floor {
                path.append(node)
                if let icon {
                    icons.append(icon)
                }
            }
            else if path.count != 0 {
                paths.append(PathData(path: path, icons: icons))
                path = []
                icons = []
            }
        }
        
        if path.count != 0 {
            paths.append(PathData(path: path, icons: icons))
        }
        
        return paths
    }
}

class PathData {
    let id = UUID()
    let path: [Node]
    let icons: [PathIcon]
    
    init(path: [Node], icons: [PathIcon]) {
        self.path = path
        self.icons = icons
    }
}

class PathIcon: Identifiable {
    let id = UUID()
    
    let node: Node
    func floor() -> Floor! { return nil }
    func view(size: CGFloat) -> (AnyView)! { return nil }
    
    init(node: Node) {
        self.node = node
    }
}

class NodeIconData: PathIcon {
    override func view(size: CGFloat) -> AnyView {
        return AnyView(NodeIcon(node: node, size: size))
    }
    
    override func floor() -> Floor {
        return node.floor
    }
}

class StartIconData: PathIcon {
    override func view(size: CGFloat) -> AnyView {
        return AnyView(PathStartIcon(node: node, size: size))
    }
    
    override func floor() -> Floor {
        return node.floor
    }
}

class FloorIconData: PathIcon {
    let floorTo: Floor
    let up: Bool
    
    override func view(size: CGFloat) -> AnyView {
        return AnyView(FloorChangeIcon(floor: floorTo, up: up, size: size))
    }
    
    override func floor() -> Floor {
        return node.floor
    }
    
    init(node: Node, floor: Floor, up: Bool) {
        self.floorTo = floor
        self.up = up
        super.init(node: node)
    }
}

class Graph {
    var nodeDict: [String: Node]
    private var edges: [Edge]
    private var edgeDict: [String: [Edge]]
    
    init(nodeDict: [String: Node], edges: [Edge], edgeDict: [String: [Edge]]) {
        self.nodeDict = nodeDict
        self.edges = edges
        self.edgeDict = edgeDict
    }
    
    func pathfind(start: String, end: String) -> PathfindingResult {
        return astar(start: start, end: end)
    }
    
    func astar(start: String, end: String) -> PathfindingResult {
        
        if (start == end) { return PathfindingResult(path: [nodeDict[start]!], edges: [])}
        
        var frontier = BinaryHeap<(Double, String)>(comparator: <)
        var came_from = [String: String]()
        var cost_so_far = [String: Double]()
        
        frontier.insert((0, start))
        cost_so_far[start] = 0
        
        while let (_, current) = frontier.pop() {
            // found path
            if current == end {
                break
            }
            
            if let neighbours = edgeDict[current]?
                .filter({!$0.blocked})
                .map({$0.neighborOf(node: current)})
                .compactMap({$0})
            {
                for neighbor in neighbours {
                    let new_cost = (
                        (cost_so_far[current] ?? Double.infinity) +
                        cost(from: current, to: neighbor)
                    )
                    if (
                        cost_so_far[neighbor] == nil ||
                        new_cost < cost_so_far[neighbor]!
                    ) {
                        cost_so_far[neighbor] = new_cost
                        let priority = new_cost + cost(from: neighbor, to: end)
                        frontier.insert((priority, neighbor))
                        came_from[neighbor] = current
                    }
                }
            }
            
        }
        
        // get resulting path data
        let path = backtrack(came_from: came_from, start: start, end: end)
                       .map({nodeDict[$0]})
                       .compactMap({$0})
        var involedEdges = [Edge]()
        for (from, to) in stride(from: 0, to: path.endIndex, by: 1).map({
            (path[$0], $0 < path.index(before: path.endIndex) ? path[$0.advanced(by: 1)] : nil)
        }) {
            if to == nil {
                break
            }
            if let edge = findEdge(from: from.id, to: to!.id) {
                involedEdges.append(edge)
            }
        }
        
        return PathfindingResult(path: path, edges: involedEdges)
    }
    
    func backtrack(came_from: [String: String], start: String, end: String) -> [String] {
        var path = [String]()
        
        if came_from[end] == nil { return [] }
        
        var temp = end
        while temp != start {
            path.append(temp)
            temp = came_from[temp]!
        }
        path.append(temp)
        
        return path
    }
    
    func findEdge(from: String, to: String) -> Edge? {
        return edgeDict[from]?.first(where: {$0.start_id == to || $0.end_id == to})
    }
    
    func cost(from: String, to: String) -> Double {
        guard let start = nodeDict[from],
              let end = nodeDict[to] else {
            return Double.infinity
        }
        return (
            sqrt(Double(start.xcoord - end.xcoord)**2 +
                 Double(start.ycoord - end.ycoord)**2) +
            Double(abs(start.floor.rawValue - end.floor.rawValue)) * 50
        )
    }
}
