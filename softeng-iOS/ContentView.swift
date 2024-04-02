//
//  ContentView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import FMDB
//import LazyPager

struct ContentView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    
    var body: some View {
        ViewController()
    }
}

#Preview {
    ContentView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
