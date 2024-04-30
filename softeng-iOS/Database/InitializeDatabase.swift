//
//  test.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation
import FMDB

func setupDatabase() async -> FMDatabase {
    
    let new = dbExists()
    let db = getDB()
    
    if new {
        runSchema(db: db)
    }
    
    do {
        let map = try await API.getMap()
        try map.saveTo(db: db)
        print("loaded database from API")
        return db
    }
    catch {
        print(error.localizedDescription)
    }
    
    if new {
        insertNodes(into: db)
        insertEdges(into: db)
        print("loaded database static CSVs")
    }
    else {
        print("used existing database (no loading)")
    }
    return db
}

func dbExists() -> Bool {
    let databasePath = URL.applicationSupportDirectory.appending(path: "softeng").appending(path: "database.sqlite")
    return !FileManager.default.fileExists(atPath: databasePath.path)
}

func getDB() -> FMDatabase {
    let databaseDir = URL.applicationSupportDirectory.appending(path: "softeng")
    try! FileManager.default.createDirectory(at: databaseDir, withIntermediateDirectories: true)
    let databaseFile = databaseDir.appending(path: "database.sqlite")
    let db = FMDatabase(url: databaseFile)
    db.open()
    
    print("Database at url: \(databaseDir.absoluteString) ")
    return db
}

func runSchema(db: FMDatabase) {
    print("ran schema")
    db.executeStatements(SCHEMA)
}














