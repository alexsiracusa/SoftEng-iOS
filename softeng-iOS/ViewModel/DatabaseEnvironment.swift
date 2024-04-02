//
//  DatabaseEnvironment.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import Foundation
import FMDB

class DatabaseEnvironment: ObservableObject {
    var fmdb: FMDatabase
    @Published var nodes: [Node]
    @Published var edges: [Edge]
    @Published var path: PathfindingResult? = nil
    
    private var nodeDict: [String: Node]
    private var edgeDict: [String: [Edge]]
    private var graph: Graph!
    
    init() {
        fmdb = setupDatabase()
        
        self.nodes = []
        self.edges = []
        self.nodeDict = [:]
        self.edgeDict = [:]
        self.graph = nil
        
        do {
            let nodeData = try selectAll(columns: Node.dbColumns, table: "Node", db: fmdb)
            let edgeData = try selectAll(columns: Edge.dbColumns, table: "Edge", db: fmdb)
            
            self.nodes = getNodes(results: nodeData)
            self.edges = getEdges(results: edgeData)
            
            // create nodeDict
            self.nodeDict = self.nodes.reduce(into: [String: Node]()) {
                $0[$1.id] = $1
            }
            
            // create edgeDict
            for node in nodes {
                self.edgeDict[node.id] = []
            }
            for edge in self.edges {
                self.edgeDict[edge.start_id]?.append(edge)
                self.edgeDict[edge.end_id]?.append(edge)
            }
            
            self.graph = Graph(nodeDict: nodeDict, edges: edges, edgeDict: edgeDict)
            self.path = graph.pathfind(start: "AHALL00203", end: "GLABS014L2")
            
            initializeEdges()
        }
        catch {
            print("failed to read map data")
        }
    }
    
    func initializeEdges() {
        for edge in edges {
            edge.start = nodeDict[edge.start_id]
            edge.end = nodeDict[edge.end_id]
        }
    }
}


