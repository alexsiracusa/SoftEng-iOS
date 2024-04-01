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
    
    @State var mapPosition: CGPoint = CGPoint(x: 0, y: 0)
    @State var mapSize: CGSize = CGSize(width: 0, height: 0)
    
    @State var origin: CGPoint = CGPoint(x: 0, y: 0)
    
    var body: some View {
        ZoomableScrollView(zoom: $zoom, offset: $offset, origin: $origin) {
            Image("00_thelowerlevel1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.ignoresSafeArea()
                .overlay(
                    GeometryReader { proxy in
                        //self.mapPosition = proxy.frame.origin
                        self.mapSize = proxy.size
                        return Text("")
                    }
                    .border(.red)
                )
        }
        .coordinateSpace(name: "scrollView")
        //.ignoresSafeArea()
        .border(.blue)
        .zIndex(0)
        .overlay(
            GeometryReader { proxy in
                ForEach(database.nodes) { node in
                    //let _ = Self._printChanges()
                    if node.floor == .L1 {
                        Circle()
                            .fill(.red)
                            .frame(width: 8, height: 8)
                            .position(
                                //x: (proxy.size.width * node.x_percent) - offset.y,
                                //y: (proxy.size.height * node.y_percent) - offset.x
                                //x: (mapSize.width * node.x_percent) * zoom + offset.x + mapPosition.x,
                                //y: (mapSize.height * node.y_percent) * zoom  + offset.y + mapPosition.y
                                x: (mapSize.width * node.x_percent) * zoom - offset.x,
                                y: (mapSize.height * node.y_percent * zoom) - offset.y //+ mapPosition.y
                            )
                            .zIndex(1)
                    }
                }
                VStack {
                    Text("Offset: \(offset)")
                    Text("Zoom: \(zoom)")
                    Text("Map Position: \(mapPosition)")
                    Text("Map Size: \(mapSize)")
                    Text("Origin: \(origin)")
                }
                .padding(.top, 40)
                
                Circle()
                    .fill(.blue)
                    .frame(width: 8, height: 8)
                    //.position(CGPoint(x: 0, y: 0))
                    .position(CGPoint(x: 0, y: 0))
            }
        )
    }
}

#Preview {
    FloorView()
        .environmentObject(DatabaseEnvironment())
}
