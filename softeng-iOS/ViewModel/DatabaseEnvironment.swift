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
    // if the view has loaded all data from the database
    @Published var loaded: Bool = false
    
    // raw data
    var fmdb: FMDatabase!
    @Published var nodes: [Node]!
    @Published var edges: [Edge]!
    
    // saved locations
    @Published var savedLocations = Set<Node>() {
        didSet {
            let savedNodes = Array(savedLocations.sorted(by: {$0.id > $1.id}))
            do {
                try saveSavedNodes(into: fmdb, nodes: savedNodes)
            }
            catch {
                print(error)
            }
        }
    }
    
    //
    @Published var selectedNode: Node? = nil
    
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
    private var nodeDict: [String: Node]!
    private var edgeDict: [String: [Edge]]!
    private var graph: Graph!
    
    // quick lookup for searching
    private var nodeSearchList: [String]!
    private var nodeSearchDict: [String: Node]!
    
    // gift request data
    @Published var cartItems: [CartItem]?
    @Published var cart: [CartItem: Int] = [:]
    func addToCart(item: CartItem, quantity: Int) {
        cart[item] = (cart[item] ?? 0) + quantity
    }
    func setItemQuantity(item: CartItem, quantity: Int) {
        cart[item] = quantity
    }
    func removeFromCart(item: CartItem) {
        cart[item] = nil
    }
    func cartSize() -> Int {
        return cart.values.reduce(0, +)
    }
    func cartTotal() -> Double {
        return cartSubTotal() + cartTax() + cartShipping()
    }
    func cartSubTotal() -> Double {
        return cart.reduce(0, {$0 + (Double($1.value) * ($1.key.priceDouble ?? 0))})
    }
    func cartTax() -> Double {
        return 0.0625 * cartSubTotal()
    }
    func cartShipping() -> Double {
        return 2.99
    }
    func clearCart() {
        self.cart = [:]
    }
    
    init() {}
    
    static var example: DatabaseEnvironment? {
        let database = DatabaseEnvironment()
        
        let db = getDB()
        runSchema(db: db)
        insertNodes(into: db)
        insertEdges(into: db)
        database.fmdb = db
        
        database.nodes = []
        database.edges = []

        database.nodeDict = [:]
        database.edgeDict = [:]
        database.graph = nil

        database.nodeSearchList = []
        database.nodeSearchDict = [:]
        
        database.cartItems = CART_ITEMS
        database.cart = [
            CART_ITEMS[0]: 1,
            CART_ITEMS[1]: 1,
            CART_ITEMS[2]: 4,
        ]

        do {
            try database.loadDatabase()
            return database
        }
        catch {
            print("failed to read map data")
            return nil
        }
    }
    
    func load() async {
        Task { @MainActor in
            self.fmdb = await setupDatabase()
            
            self.nodes = []
            self.edges = []
            
            self.nodeDict = [:]
            self.edgeDict = [:]
            self.graph = nil
            
            self.nodeSearchList = []
            self.nodeSearchDict = [:]
            
            // try to setup database (needs to succeed)
            do {
                try self.loadDatabase()
                try self.loadSavedNodes()
                self.loaded = true
            }
            catch {
                print("failed to read map data")
            }
            
            // try to fetch cart items (is allowed to fail)
            do {
                try await self.loadCartItems()
            }
            catch {
                print(error)
                print("failed to get cart items on launch")
            }
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
    
    func loadSavedNodes() throws {
        do {
            let savedNodes = try getSavedNodes(from: fmdb)
            self.savedLocations = Set(savedNodes.map({graph.nodeDict[$0]}).compactMap({ $0 }))
        }
        catch let error {
            self.loaded = false
            throw error
        }
    }
    
    func loadCartItems() async throws {
        Task { @MainActor in
            self.cartItems = try await API.getCartItems()
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
        selectedNode = nil
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
    
    func resetPath() {
        pathStart = nil
        pathEnd = nil
        path = nil
    }
    
    func displayNodes(zoom: CGFloat) -> [Node] {
        let displayGroup: [Set<NodeType>] = [
            Set<NodeType>([.EXIT]),
            Set<NodeType>([.STAI, .ELEV]),
            Set<NodeType>([.INFO, .DEPT, .REST, .BATH]),
            Set<NodeType>([.SERV, .RETL, .LABS, .CONF]),
            Set<NodeType>([.HALL]),
        ]
        
        return nodes
            .filter({!displayGroup[4].contains($0.type)})
            .filter({!displayGroup[3].contains($0.type) || zoom > 4})
            .filter({!displayGroup[2].contains($0.type) || zoom > 3})
            .filter({!displayGroup[1].contains($0.type) || zoom > 2})
            .filter({!displayGroup[0].contains($0.type) || zoom > 2})
    }
    
}


