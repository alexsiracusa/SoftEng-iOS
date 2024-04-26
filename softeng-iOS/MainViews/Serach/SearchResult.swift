//
//  SearchResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/13/24.
//

import SwiftUI

struct SearchResult: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let node: Node
    
    var isSelected: Bool {
        return viewModel.selectedFloor.floor == node.floor
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                FloorIcon(
                    selected: isSelected,
                    name: String(describing: node.floor),
                    size: 25
                )
                .padding(.trailing, 15)
                
                Text("\(node.long_name) (\(node.building))")
                    .lineLimit(2)
                
                Spacer()
                
                node.icon
                    .resizable()
                    .frame(width: 25, height: 25)
                
                Image(systemName: "arrow.up.left")
                    .padding(.leading, 10)
            }
            .padding(.vertical, 17)
            .padding(.horizontal, 20)
            
            Divider()
                .padding(.leading, 60)
        }
    }
}

#Preview {
    SearchResult(node: Node.example)
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
