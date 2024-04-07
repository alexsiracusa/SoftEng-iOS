//
//  SearchResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchResult: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let node: Node
    @Binding var fullscreen: Bool
    @FocusState var focused: Bool
    
    var isSelected: Bool {
        return viewModel.selectedFloor.floor == node.floor
    }
    
    var body: some View {
        Button(action: {
            database.selectedNode = node
            viewModel.setFloor(floor: node.floor)
            self.focused = false
            self.fullscreen = false
            viewModel.sheet = true
        }) {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    FloorIcon(
                        selected: isSelected,
                        name: String(describing: node.floor),
                        size: 25
                    )
                    .padding(.trailing, 15)
                    
                    Text("\(node.short_name) (\(node.building))")
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.left")
                        .padding(.leading, 10)
                }
                .padding(.vertical, 17)
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.leading, 60)
            }
        }
        .buttonStyle(GreyBackgroundButton())
        
    }
    
    
    
}

#Preview {
    SearchResult(node: Node.example, 
                 fullscreen: .constant(false),
                 focused: FocusState<Bool>()
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
