//
//  softeng_iOSApp.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import SwiftData

@main
struct softeng_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
    }
}
