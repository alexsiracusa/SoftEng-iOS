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
                    if let selected = database.selectedNode, selected.floor == viewModel.selectedFloor.floor {
                        AnyView(
                            renderIcon(icon: NodeIconData(node: selected))
                        )
                    }
                    
                    if let path = database.path {
                        let displayData = path.displayData(floor: floor.floor)
                        
                        ForEach(displayData, id: \.id) { pathData in
                            ZStack {
                                renderPath(nodes: pathData.path)
                                
                                ForEach(pathData.icons) { icon in
                                    renderIcon(icon: icon)
                                        .zIndex(999)
                                }
                            }
                        }
                    }
                    else {
                        renderExploreIcons()
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
    
    let iconSize: CGFloat = 30
    
    func renderIcon(icon: PathIcon) -> AnyView {
        AnyView (
            icon.view(size: iconSize)
                .position(getPoint(node: icon.node))
        )
    }
    
    func renderPath(nodes: [Node]) -> AnyView {
        guard !nodes.isEmpty else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Path() { path in
                path.move(to: getPoint(node: nodes[0]))
                for node in nodes[1..<nodes.count] {
                    path.addLine(to: getPoint(node: node))
                }
            }
                .stroke(.red, lineWidth: 2)
        )
    }
    
    func renderExploreIcons() -> AnyView {
        return AnyView(
            ForEach(
                database.displayNodes(zoom: zoom)
                    .filter({$0.floor == viewModel.selectedFloor.floor})
            ) { node in
                NodeIcon(node: node, size: iconSize)
                    .position(getPoint(node: node))
            }
        )
    }
}

#Preview {
    FloorView(floor: .constant(FloorData(floor: .F1, image_name: "01_thefirstfloor")))
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
