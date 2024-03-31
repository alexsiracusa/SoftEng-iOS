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
        
        do {
            let nodeData = try selectAll(columns: Node.dbColumns, table: "Node", db: fmdb)
            let edgeData = try selectAll(columns: Edge.dbColumns, table: "Edge", db: fmdb)
            
            self.nodes = getNodes(results: nodeData)
            self.edges = getEdges(results: edgeData)
        }
        catch {
            self.nodes = []
            self.edges = []
            print("failed to read map data")
        }
    }
}

