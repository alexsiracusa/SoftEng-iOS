//
//  Helper.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation
import FMDB

func insert(values: [String], columns: [String], table: String, db: FMDatabase) throws {
    let query = """
    INSERT INTO \(table) (
        \(columns.map({"\($0)"}).joined(separator: ","))
    )
    VALUES (
        \(values.map({"'\($0)'"}).joined(separator: ","))
    );
    """
    
    do {
        try db.executeUpdate(query, values: nil)
    } catch let error {
        throw error
    }
}

func selectAll(columns: [String], table: String, db: FMDatabase) throws -> FMResultSet {
    let query = """
    SELECT
        \(columns.map({"\($0)"}).joined(separator: ","))
    FROM
        \(table);
    """
    do {
        let rows = try db.executeQuery(query, values: nil)
        return rows
    } catch let error {
        throw error
    }
}

func getNodes(results: FMResultSet) -> [Node] {
    var nodes = [Node]()
    
    while(results.next()) {
        if let node = Node(result: results) {
            nodes.append(node)
        }
    }
    
    return nodes
}

func getEdges(results: FMResultSet) -> [Edge] {
    var edges = [Edge]()
    
    while(results.next()) {
        if let edge = Edge(result: results) {
            edges.append(edge)
        }
    }
    
    return edges
}



