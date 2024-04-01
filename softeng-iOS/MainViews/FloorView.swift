//
//  FloorView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import SwiftUI

struct FloorView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @State var zoom: CGFloat = 1.0
    @State var offset: CGPoint = CGPoint(x: 0, y: 0)
    @State var origin: CGPoint = CGPoint(x: 0, y: 0)
    
    @State var mapSize: CGSize = CGSize(width: 0, height: 0)
    
    
    var body: some View {
        ZoomableScrollView(zoom: $zoom, offset: $offset, origin: $origin) {
            Image("00_thelowerlevel1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(
                    GeometryReader { proxy in
                        self.mapSize = proxy.size
                        return Text("")
                    }
                )
        }
        .zIndex(0)
        .overlay(
            GeometryReader { proxy in
                ForEach(database.nodes) { node in
                    if node.floor == .L1 {
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .position(
                                x: (mapSize.width * node.x_percent * zoom) - offset.x + origin.x,
                                y: (mapSize.height * node.y_percent * zoom) - offset.y + origin.y
                            )
                            .zIndex(1)
                    }
                }
            }
        )
    }
}

#Preview {
    FloorView()
        .environmentObject(DatabaseEnvironment())
}
