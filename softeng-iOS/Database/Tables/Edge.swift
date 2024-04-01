//
//  Edge.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import Foundation
import FMDB

class Edge: Identifiable {
    
    static let dbColumns = ["id", "start_id", "end_id", "blocked", "heat"]
    
    let id: String
    let start_id: String
    let end_id: String
    let blocked: Bool
    let heat: Int
    
    var start: Node! = nil
    var end: Node! = nil
    
    func onFloor(floor: Floor) -> Bool {
        return start.floor == floor && end.floor == floor
    }
    
    init(id: String, start_id: String, end_id: String, blocked: Bool, heat: Int) {
        self.id = id
        self.start_id = start_id
        self.end_id = end_id
        self.blocked = blocked
        self.heat = heat
    }
    
    init?(result: FMResultSet) {
        do {
            self.id = try result.string(forColumn: "id") ?! RuntimeError("failed to convert id")
            self.start_id = try result.string(forColumn: "start_id") ?! RuntimeError("failed to convert start_id")
            self.end_id = try result.string(forColumn: "end_id") ?! RuntimeError("failed to convert end_id")
            self.blocked = try result.int(forColumn: "blocked") == 1 ?! RuntimeError("failed to convert blocked")
            self.heat = try Int(result.int(forColumn: "heat")) ?! RuntimeError("failed to convert heat")
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
