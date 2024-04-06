//
//  DatabaseEnvironment.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import Foundation
import FMDB
import Fuse

class DatabaseEnvironment: ObservableObject {
    // if the view has loaded data from the database
    @Published var loaded: Bool = false
    
    // raw data
    var fmdb: FMDatabase
    @Published var nodes: [Node]
    @Published var edges: [Edge]
    
    // pathfinding
    @Published var path: PathfindingResult? = nil
    @Published var pathStart: Node? = nil {
        didSet {
            tryPath()
        }
    }
    @Published var pathEnd: Node? = nil {
        didSet {
            tryPath()
        }
    }
    
    // quick lookup for pathfinding
    private var nodeDict: [String: Node]
    private var edgeDict: [String: [Edge]]
    private var graph: Graph!
    
    // quick lookup for searching
    private var nodeSearchList: [String]
    private var nodeSearchDict: [String: Node]
    
    init() {
        fmdb = setupDatabase()
        
        self.nodes = []
        self.edges = []
        
        self.nodeDict = [:]
        self.edgeDict = [:]
        self.graph = nil
        
        self.nodeSearchList = []
        self.nodeSearchDict = [:]
        
        do {
            try self.loadDatabase()
        }
        catch {
            print("failed to read map data")
        }
        
    }
    
    func loadDatabase() throws {
        do {
            let nodeData = try selectAll(columns: Node.dbColumns, table: "Node", db: fmdb)
            let edgeData = try selectAll(columns: Edge.dbColumns, table: "Edge", db: fmdb)
            
            self.nodes = getNodes(results: nodeData)
            self.edges = getEdges(results: edgeData)
            
            preprossesData()
            
            self.graph = Graph(nodeDict: nodeDict, edges: edges, edgeDict: edgeDict)
            self.loaded = true
        }
        catch let error {
            self.loaded = false
            throw error
        }
    }
    
    private func preprossesData() {
        // create nodeDict
        self.nodeDict = self.nodes.reduce(into: [String: Node]()) {
            $0[$1.id] = $1
        }
        
        // create edgeDict
        for node in nodes {
            self.edgeDict[node.id] = []
        }
        for edge in self.edges {
            self.edgeDict[edge.start_id]?.append(edge)
            self.edgeDict[edge.end_id]?.append(edge)
        }
        
        // initialize edges
        for edge in edges {
            edge.start = nodeDict[edge.start_id]
            edge.end = nodeDict[edge.end_id]
        }
        
        // initialize search data structures
        self.nodeSearchList = self.nodes.map({$0.searchString})
        self.nodeSearchDict = self.nodes.reduce(into: [String: Node]()) {
            $0[$1.searchString] = $1
        }
        
    }
    
    func tryPath() {
        guard let pathStart, let pathEnd else {
            return
        }
        pathfind(start: pathStart.id, end: pathEnd.id)
    }
    
    func pathfind(start: String, end: String) {
        self.path = graph.pathfind(start: start, end: end)
    }
    
    func searchNodes(query: String) -> [Node] {
        let fuse = Fuse()
        
        let results = self.nodes
            .filter({$0.type != .HALL})
            .map({
            (
                score: fuse.search(query.lowercased(), in: $0.searchString)?.score ?? 1,
                node: $0
            )
            })
            .sorted(by: {$0.score < $1.score})
            .filter({$0.score < 0.75})
            .map({$0.node})
        
        return results
    }
    
}


