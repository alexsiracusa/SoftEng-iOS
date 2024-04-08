//
//  NodeDetail.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/6/24.
//

import SwiftUI

struct NodeDetail: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var height: PresentationDetent {
        return viewModel.sheetHeight
    }
    
    var node: Node? {
        return database.selectedNode
    }
    
    var selected: Bool {
        return viewModel.selectedFloor.floor == node!.floor
    }
    
    func floorIcon(node: Node) -> some View {
        FloorIcon(
            selected: selected,
            name: node.floor.name,
            size: 25)
    }
    
    var body: some View {
        VStack {
            if let node {
                HStack(alignment: .center) {
                    Button(action: {
                        viewModel.setFloor(floor: node.floor)
                    }) {
                        floorIcon(node: node)
                    }
                    .buttonStyle(ScaleButton())
                    
                    Text("\(node.long_name)")
                        .lineLimit(height == SHEET_LOW ? 1 : nil)
                    
                    Spacer()
                    
                    node.icon
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
            
                ScrollView {
                    VStack(alignment: .leading) {
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                DirectionsButton(
                                    node: node,
                                    size: 40
                                )
                                LocationButton(
                                    node: node,
                                    size: 40
                                )
                                SaveButton(
                                    node: node,
                                    size: 40
                                )
                            }
                            .frame(height: 40)
                            .padding(.horizontal, 10)
                            .padding(.top, 10)
                        }
                        
                        if viewModel.pickDirectionsView {
                            DirectionsPicker()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let database = DatabaseEnvironment()
    database.selectedNode = Node.example
    
    return NodeDetail()
        .environmentObject(database)
        .environmentObject(ViewModel())
}
