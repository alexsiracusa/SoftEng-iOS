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
    
    init() {
        fmdb = setupDatabase()
        
        self.nodes = []
        self.edges = []
        
        do {
            let nodeData = try selectAll(columns: Node.dbColumns, table: "Node", db: fmdb)
            let edgeData = try selectAll(columns: Edge.dbColumns, table: "Edge", db: fmdb)
            
            self.nodes = getNodes(results: nodeData)
            self.edges = getEdges(results: edgeData)
            initializeEdges()
        }
        catch {
            print("failed to read map data")
        }
    }
    
    func initializeEdges() {
        var node_dict = [String: Node]()
        for node in nodes {
            node_dict[node.id] = node
        }
        
        for edge in edges {
            edge.start = node_dict[edge.start_id]
            edge.end = node_dict[edge.end_id]
        }
    }
}

