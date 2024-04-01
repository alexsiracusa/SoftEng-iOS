//
//  ContentView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/28/24.
//

import SwiftUI
import FMDB

struct ContentView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    
    @State var data = ["00_thelowerlevel1"]
    @State var zoom: CGFloat = 1.0
    

    var body: some View {
        ZoomableScrollView(zoom: $zoom) {
            FloorView(zoom: $zoom)
        }
    }
}

#Preview {
    ContentView()
}
