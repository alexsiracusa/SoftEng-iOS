//
//  FloorView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import SwiftUI

struct FloorView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @Binding var zoom: CGFloat
    
    var body: some View {
        Image("00_thelowerlevel1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .zIndex(0)
            .overlay(GeometryReader { proxy in
                ForEach(database.nodes) { node in
                    if node.floor == .L1 {
                        Circle()
                            .fill(.red)
                            .frame(width: 8 * (1 / zoom), height: 8 * (1 / zoom))
                            .position(
                                x: proxy.size.width * node.x_percent,
                                y: proxy.size.height * node.y_percent
                            )
                            .zIndex(1)
                    }
                }
            })
    }
}

#Preview {
    FloorView(zoom: .constant(1))
        .environmentObject(DatabaseEnvironment())
}
