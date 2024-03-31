//
//  ContentView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import FMDB
import LazyPager

struct ContentView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    
    @State var data = ["00_thelowerlevel1"]

    var body: some View {
        LazyPager(data: data) { element in
            FloorView()
        }
        .zoomable(min: 1, max: 10)
    }
}

#Preview {
    ContentView()
}
