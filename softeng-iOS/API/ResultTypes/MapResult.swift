//
//  MapResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/25/24.
//

import Foundation
import FMDB

struct MapResult: Decodable {
    let nodes: [NodeResult]
    let edges: [EdgeResult]
    
    func saveTo(db: FMDatabase) throws {
        if !db.beginTransaction() {
            throw db.lastError()
        }
        
        do {
            try db.executeUpdate("DROP TABLE IF EXISTS Node;", values: nil)
            try db.executeUpdate("DROP TABLE IF EXISTS Edge;", values: nil)
            
            try db.executeUpdate(CREATE_NODE_TABLE, values: nil)
            try db.executeUpdate(CREATE_EDGE_TABLE, values: nil)
            //try db.executeUpdate(SCHEMA, values: nil)
        }
        catch {
            throw error
        }
        
        saveNodes(db: db)
        saveEdges(db: db)
        
        if !db.commit() {
            throw db.lastError()
        }
    }
    
    private func saveNodes(db: FMDatabase) {
        for row in nodes.map({$0.rowArray}) {
            do {
                try insert(values: row, columns: NODE_COLUMNS, table: "Node", db: db)
            } catch {
                print("failed to insert \(row) into Node")
            }
        }
    }
    
    private func saveEdges(db: FMDatabase) {
        for row in edges.map({$0.rowArray}) {
            do {
                try insert(values: row, columns: EDGE_COLUMNS, table: "Edge", db: db)
            } catch {
                print("failed to insert \(row) into Edge")
            }
        }
    }
}

struct NodeResult: Decodable {
    let nodeID: String
    let xcoord: Int
    let ycoord: Int
    let floor: String
    let building: String
    let nodeType: String
    let longName: String
    let shortName: String
    
    var rowArray: [String] {
        return ["\(nodeID)", "\(xcoord)", "\(ycoord)", "\(floor)", "\(building)", "\(nodeType)", "\(longName)", "\(shortName)"]
    }
}

struct EdgeResult: Decodable {
    let startNodeID: String
    let endNodeID: String
    let blocked: Bool
    let heat: Int
    
    var rowArray: [String] {
        return ["\(startNodeID)_\(endNodeID)", "\(startNodeID)", "\(endNodeID)", "\(blocked ? 1 : 0)", "\(heat)"]
    }
}


