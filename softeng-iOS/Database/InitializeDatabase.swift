//
//  test.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/30/24.
//

import Foundation
import FMDB

func setupDatabase() async -> FMDatabase {
    do {
        let map = try await getMap()
        print(map)
    }
    catch {
        print(error.localizedDescription)
    }
    
    let db = getDB()
    runSchema(db: db)
    insertNodes(into: db)
    insertEdges(into: db)
    return db
}

func getDB() -> FMDatabase {
    let databaseDir = URL.applicationSupportDirectory.appending(path: "softeng")
    try! FileManager.default.createDirectory(at: databaseDir, withIntermediateDirectories: true)
    let databaseFile = databaseDir.appending(path: "database.sqlite")
    let db = FMDatabase(url: databaseFile)
    db.open()
    
    print("Database created at: \(databaseDir) ")
    return db
}

func runSchema(db: FMDatabase) {
    db.executeStatements(SCHEMA)
    print("run schema")
}














