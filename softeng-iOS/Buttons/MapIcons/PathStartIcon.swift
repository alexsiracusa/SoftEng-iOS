//
//  PathStartIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/30/24.
//

import SwiftUI

struct PathStartIcon: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            database.selectedNode = node
            viewModel.focusNode()
        }) {
            FromIcon(size: size * 0.9)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PathStartIcon(node: Node.example, size: 100)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
