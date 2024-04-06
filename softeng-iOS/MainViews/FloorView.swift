//
//  FloorView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import SwiftUI

struct FloorView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
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
        return getPoint(x_percent: node.x_percent, y_percent: node.y_percent)
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
        .overlay(
            GeometryReader { proxy in
                ZStack {
                    // Render Selected Node
                    if let selected = database.selectNode {
                        AnyView(
                            renderNode(color: .red, node: selected)
                        )
                    }
                    
                    if let path = database.path {
                        ForEach(path.displayNodes, id: \.node.id) { color, node in
                            AnyView(
                                renderNode(color: color, node: node)
                            )
                        }
                        ForEach(path.displayEdges, id: \.edge.id) { color, edge in
                            AnyView(
                                renderEdge(color: color, edge: edge)
                            )
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
        .zIndex(0)
        .background(COLOR_BG_P)
    }
    
    func renderNode(
        color: Color,
        node: Node
    ) -> any View {
        if node.floor == floor.floor {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
                .position(getPoint(node: node))
                .zIndex(1)
        }
        else {
            EmptyView()
        }
    }
    
    func renderEdge(
        color: Color,
        edge: Edge
    ) -> any View {
        if edge.onFloor(floor: floor.floor) {
            Path() { path in
                path.move(to: getPoint(node: edge.start))
                path.addLine(to: getPoint(node: edge.end))
            }
            .stroke(color, lineWidth: 2)
        }
        else {
            EmptyView()
        }
    }
}

#Preview {
    FloorView(floor: .constant(FloorData(floor: .F1, image_name: "01_thefirstfloor")))
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
