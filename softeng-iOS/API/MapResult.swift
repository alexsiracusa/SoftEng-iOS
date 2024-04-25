//
//  MapResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/25/24.
//

import Foundation

struct MapResult: Decodable {
    let nodes: [NodeResult]
    let edges: [EdgeResult]
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
}

struct EdgeResult: Decodable {
    let startNodeID: String
    let endNodeID: String
    let blocked: Bool
    let heat: Int
}


