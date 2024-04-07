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
    
    var node: Node? {
        return database.selectedNode
    }
    
    func floorIcon(node: Node) -> some View {
        FloorIcon(
            selected: viewModel.selectedFloor.floor == node.floor,
            name: node.floor.name,
            size: 25)
    }
    
    var body: some View {
        VStack {
            if let node {
                HStack {
                    floorIcon(node: node)
                    
                    Text("\(node.long_name)")
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 25)
            
                ScrollView {
                    VStack(alignment: .leading) {
                        
                    }
                    .padding(.horizontal, 20)
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
