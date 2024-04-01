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
    
    @State var data = ["00_thelowerlevel1"]
    @State var zoom: CGFloat = 1.0
    @State var offset: CGPoint = CGPoint(x: 0, y: 0)
    

    var body: some View {
//        LazyPager(data: data) { element in
//            Image(element)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        }
//        .zoomable(min: 1, max: 12)
        FloorView()
            .padding(.leading, 10)
            .padding(.trailing, 10)
            //.ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
