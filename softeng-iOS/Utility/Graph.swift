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
    let edges: [Edge]
    
    init(path: [Node], edges: [Edge]) {
        self.path = path
        self.edges = edges
    }
    
    var displayNodes: [(color: Color, node: Node)] {
        var nodes = [(Color, Node)]()
        nodes.append((.red, path.first!))
        nodes.append((.red, path.last!))
        return Array(nodes.uniqued(on: {$0.1.id}))
    }
    
    var displayEdges: [(color: Color, edge: Edge)] {
        var edges = [(Color, Edge)]()
        edges = self.edges.map({(.red, $0)})
        return edges
    }
}

class Graph {
    private var nodeDict: [String: Node]
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
