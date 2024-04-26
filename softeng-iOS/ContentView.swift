//
//  ContentView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import FMDB

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var database: DatabaseEnvironment
    
    var body: some View {
        if database.loaded {
            ViewController()
        }
        else {
            Text("Loading")
                .onAppear() {
                    Task {
                        await database.load()
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
