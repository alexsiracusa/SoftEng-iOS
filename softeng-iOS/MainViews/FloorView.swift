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
    
    @Binding var floor: FloorData
    
    init(floor: Binding<FloorData>) {
        _floor = floor
    }
    
    func getPoint(x_percent: CGFloat, y_percent: CGFloat) -> CGPoint {
        CGPoint(
            x: (mapSize.width * x_percent * zoom) - offset.x + origin.x,
            y: (mapSize.height * y_percent * zoom) - offset.y + origin.y
        )
    }
    
    func getPoint(node: Node) -> CGPoint {
        CGPoint(
            x: (mapSize.width * node.x_percent * zoom) - offset.x + origin.x,
            y: (mapSize.height * node.y_percent * zoom) - offset.y + origin.y
        )
    }
    
    var body: some View {
        ZoomableScrollView(zoom: $zoom, offset: $offset, origin: $origin) {
            Image(floor.image_name)
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
                ZStack {
                    ForEach(database.nodes) { node in
                        if node.floor == floor.floor {
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
                    ForEach(database.edges) { edge in
                        if edge.onFloor(floor: floor.floor) {
                            Path() { path in
                                path.move(to: getPoint(node: edge.start))
                                path.addLine(to: getPoint(node: edge.end))
                            }
                            .stroke(.red, lineWidth: 2)
                        }
                    }
                }
                .onChange(of: mapSize) {
                    self.origin = CGPoint(
                        x: 0,
                        y: (proxy.size.height / 2) - (self.mapSize.height / 2)
                    )
                }
            }
        )
    }
}

#Preview {
    FloorView(floor: .constant(FloorData(floor: .F1, image_name: "01_thefirstfloor")))
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}