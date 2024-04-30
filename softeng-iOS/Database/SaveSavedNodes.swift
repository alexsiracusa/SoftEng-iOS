//
//  SaveNodes.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import Foundation
import FMDB

func getSavedNodes(from: FMDatabase) throws -> [String] {
    let db = from
    
    do {
        let results = try db.executeQuery("SELECT node_id from \"Saved_Node\"", values: nil)
        
        var nodeIds = [String]()
        while(results.next()) {
            let id = try results.string(forColumn: "node_id") ?! RuntimeError("failed to read saved nodes")
            nodeIds.append(id)
        }
        
        return nodeIds
    } catch let error {
        throw error
    }
}

func saveSavedNodes(into: FMDatabase, nodes: [Node]) throws {
    let db = into
    
    if !db.beginTransaction() {
        throw db.lastError()
    }
    
    do {
        let results = try db.executeQuery("SELECT node_id FROM \"Saved_Node\";", values: nil)
        
        var nodeIds = Set(nodes.map({$0.id}))
        while(results.next()) {
            let id = try results.string(forColumn: "node_id") ?! RuntimeError("failed to read saved nodes")
            if nodeIds.contains(id) {
                nodeIds.remove(id)
            }
            else {
                print("deleting")
                try db.executeQuery("""
                    DELETE FROM "Saved_Node" WHERE node_id = "\(id)";
                """, values: nil)
            }
        }
        
        let toAdd = Array(nodeIds)
        if (toAdd.count > 0) {
            for id in toAdd {
                try insert(values: [id], columns: ["node_id"], table: "Saved_Node", db: db)
            }
        }
    } catch let error {
        db.rollback()
        throw error
    }
    
    if !db.commit() {
        throw db.lastError()
    }
}
