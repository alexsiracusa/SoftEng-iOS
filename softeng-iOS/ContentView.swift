//
//  ContentView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        NavigationSplitView {
            List {
                Image("00_thelowerlevel1.png")
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addNodes) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addNodes() {
        setupDatabase()
    }
}

#Preview {
    ContentView()
}
