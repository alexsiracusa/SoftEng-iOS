//
//  Helper.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation
import FMDB

func insert(values: [String], into: String, columns: [String], with: FMDatabase) throws {
    let table = into
    let db = with
    
    let query = """
    INSERT INTO \(table) (
        \(columns.map({"'\($0)'"}).joined(separator: ","))
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




