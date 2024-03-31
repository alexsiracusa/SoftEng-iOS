//
//  ImportGraphData.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation
import FMDB

func getCSVData(from: URL) -> [[String]]? {
    do {
        let content = try String(contentsOfFile: from.path(), encoding: .utf8)
        let parsedCSV: [[String]] = content.components(
            separatedBy: "\n"
        ).map{ $0.components(separatedBy: ",") }
        return parsedCSV
    }
    catch {
        return nil
    }
}

func insertNodes(into: FMDatabase) {
    let db = into
    
    guard let filePath = Bundle.main.url(forResource: "nodes", withExtension: "csv") else {
        print("failed to find nodes file")
        return
    }
    
    guard let rows = getCSVData(from: filePath) else {
        print("failed to parse csv file")
        return
    }
    
    let columns = ["id", "xcoord", "ycoord", "floor", "building", "type", "long_name", "short_name"]
    for row in rows.dropFirst() {
        do {
            try insert(values: row, columns: columns, table: "Node", db: db)
        } catch {
            print("failed to insert \(row) into Node")
        }
    }
    
}

func insertEdges(into: FMDatabase) {
    let db = into
    
    guard let filePath = Bundle.main.url(forResource: "edges", withExtension: "csv") else {
        print("failed to find edges file")
        return
    }
    
    guard let rows = getCSVData(from: filePath) else {
        print("failed to parse csv file")
        return
    }
    
    let columns = ["id", "start_id", "end_id"]
    for row in rows.dropFirst() {
        do {
            try insert(values: row, columns: columns, table: "Edge", db: db)
        } catch {
            print("failed to insert \(row) into Edge")
        }
    }
    
}


