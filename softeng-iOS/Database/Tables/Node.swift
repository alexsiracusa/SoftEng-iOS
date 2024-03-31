//
//  Node.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import Foundation
import FMDB

enum Floor: Int {
    case L2 = -1
    case L1 = 0
    case F1 = 1
    case F2 = 2
    case F3 = 3
}

extension Floor {
    init?(_ string: String?) {
        guard let string = string else { return nil }
        switch string {
        case "L2": self = .L2
        case "L1": self = .L1
        case "1": self = .F1
        case "2": self = .F2
        case "3": self = .F3
        default: return nil
        }
    }
}

enum NodeType: String {
    case CONF = "CONF"
    case DEPT = "DEPT"
    case HALL = "HALL"
    case LABS = "LABS"
    case REST = "REST"
    case SERV = "SERV"
    case ELEV = "ELEV"
    case EXIT = "EXIT"
    case STAI = "STAI"
    case RETL = "RETL"
    case INFO = "INFO"
    case BATH = "BATH"
}

extension NodeType {
    init?(_ string: String?) {
        guard let string = string else { return nil }
        if let type =  NodeType(rawValue: string.uppercased()) {
            self = type
        }
        else {
            return nil
        }
    }
}

class Node {
    
    static let dbColumns = ["id", "xcoord", "ycoord", "floor", "building", "type", "long_name", "short_name"]
    
    let id: String
    let xcoord: Int
    let ycoord: Int
    let floor: Floor
    let building: String
    let type: NodeType
    let long_name: String
    let short_name: String
    
    init(
        id: String, xcoord: Int, ycoord: Int, floor: Floor, building: String,
        type: NodeType, long_name: String, short_name: String
    ) {
        self.id = id
        self.xcoord = xcoord
        self.ycoord = ycoord
        self.floor = floor
        self.building = building
        self.type = type
        self.long_name = long_name
        self.short_name = short_name
    }
    
    init?(result: FMResultSet) {
        do {
            self.id = try result.string(forColumn: "id") ?! RuntimeError("failed to convert id")
            self.xcoord = try Int(result.int(forColumn: "xcoord")) ?! RuntimeError("failed to convert xcoord")
            self.ycoord = try Int(result.int(forColumn: "ycoord")) ?! RuntimeError("failed to convert ycoord")
            self.floor = try Floor(result.string(forColumn: "floor")) ?! RuntimeError("failed to convert floor")
            self.building = try result.string(forColumn: "building") ?! RuntimeError("failed to convert building")
            self.type = try NodeType(result.string(forColumn: "type")) ?! RuntimeError("failed to convert type")
            self.long_name = try result.string(forColumn: "long_name") ?! RuntimeError("failed to convert long_name")
            self.short_name = try result.string(forColumn: "short_name") ?! RuntimeError("failed to convert short_name")
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}




