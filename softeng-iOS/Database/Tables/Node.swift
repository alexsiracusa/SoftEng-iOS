//
//  Node.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import Foundation
import FMDB
import SwiftUI

enum Floor: Int, Comparable {
    case L2 = -1
    case L1 = 0
    case F1 = 1
    case F2 = 2
    case F3 = 3
    
    static func <(a: Floor, b: Floor) -> Bool {
        return a.rawValue < b.rawValue
    }
    
    var description: String {
        switch self {
        case .L2: return "L2 The Lower Level 2"
        case .L1: return "L2 The Lower Level 1"
        case .F1: return "F1 The First Floor 1"
        case .F2: return "F2 The Second Floor 2"
        case .F3: return "F3 The Third Floor 3"
        }
    }
    
    var name: String {
        switch self {
        case .L2: return "L2"
        case .L1: return "L2"
        case .F1: return "F1"
        case .F2: return "F2"
        case .F3: return "F3"
        }
    }
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
    case CONF = "CONF" // ConferenceIcon
    case DEPT = "DEPT" // DepartmentIcon
    case HALL = "HALL"
    case LABS = "LABS" // LabIcon
    case REST = "REST" // RestroomIcon
    case SERV = "SERV" // Service Icon or ATM
    case ELEV = "ELEV" // ElevatorIcon
    case EXIT = "EXIT" // ExitIcon
    case STAI = "STAI" // EscalatorIcon
    case RETL = "RETL" // VendingIcon or CafeIcon or GiftShopIcon or FoodIcon
    case INFO = "INFO" // InfoIcon
    case BATH = "BATH" // RestroomIcon
    
    var description: String {
        switch self {
        case .CONF: return "Conference"
        case .DEPT: return "Department"
        case .HALL: return "Hallway"
        case .LABS: return "Labratory"
        case .REST: return "Restroom"
        case .SERV: return "Service"
        case .ELEV: return "Elevator"
        case .EXIT: return "Exit"
        case .STAI: return "Stairs"
        case .RETL: return "Retail"
        case .INFO: return "Information"
        case .BATH: return "Bathroom"
        }
    }
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

class Node: Identifiable, Equatable {
    static let dbColumns = ["id", "xcoord", "ycoord", "floor", "building", "type", "long_name", "short_name"]
    
    let id: String
    let xcoord: Int
    let ycoord: Int
    let floor: Floor
    let building: String
    let type: NodeType
    let long_name: String
    let short_name: String
    
    var x_percent: Double {
        return Double(self.position.x) / 5000
    }
    
    var y_percent: Double {
        return Double(self.position.y) / 3400
    }
    
    var position: CGPoint {
        return CGPoint(x: self.xcoord, y: self.ycoord) + FLOOR_OFFSETS[self.floor]!
    }
    
    var searchString: String {
        return [long_name, short_name, building, type.description, floor.description + id]
            .joined(separator: " ")
            .lowercased()
    }
    
    var icon: Image {
        switch type {
        case .CONF: return Image(uiImage: UIImage(named: "ConferenceIcon")!)
        case .DEPT: return Image(uiImage: UIImage(named: "DepartmentIcon")!)
        case .HALL: return Image(uiImage: UIImage(named: "InfoIcon")!)
        case .LABS: return Image(uiImage: UIImage(named: "LabIcon")!)
        case .REST: return Image(uiImage: UIImage(named: "RestroomIcon")!)
        case .SERV: 
            if self.long_name.lowercased().contains("atm") {
                return Image(uiImage: UIImage(named: "ATMIcon")!)
            }
            return Image(uiImage: UIImage(named: "ServiceIcon")!)
        case .ELEV: return Image(uiImage: UIImage(named: "ElevatorIcon1")!)
        case .EXIT: return Image(uiImage: UIImage(named: "ExitIcon")!)
        case .STAI: return Image(uiImage: UIImage(named: "EscalatorIcon")!)
        case .RETL: 
            if self.long_name.lowercased().contains("vending") {
                return Image(uiImage: UIImage(named: "VendingIcon")!)
            }
            else if self.long_name.lowercased().contains("cafe") {
                return Image(uiImage: UIImage(named: "CafeIcon")!)
            }
            else if self.long_name.lowercased().contains("gift") {
                return Image(uiImage: UIImage(named: "GiftShopIcon")!)
            }
            return Image(uiImage: UIImage(named: "FoodIcon")!)
        case .INFO: return Image(uiImage: UIImage(named: "InfoIcon")!)
        case .BATH: return Image(uiImage: UIImage(named: "RestroomIcon")!)
        }
    }
    
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
    
    static var example: Node {
        return Node(
            id: "ACONF00102",
            xcoord: 1580,
            ycoord: 2538,
            floor: .F2,
            building: "BTM",
            type: .HALL,
            long_name: "Hall",
            short_name: "Hall"
        )
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}




