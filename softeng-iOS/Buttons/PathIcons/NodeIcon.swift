//
//  NodeIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/17/24.
//

import SwiftUI

struct NodeIcon: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            database.selectedNode = node
            viewModel.focusNode()
        }) {
            node.icon
                .resizable()
                .frame(width: size, height: size)
                .padding(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NodeIcon(node: Node.example, size: 100)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
