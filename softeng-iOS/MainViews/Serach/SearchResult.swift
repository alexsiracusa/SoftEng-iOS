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
    
    // search data
    @Binding var search: String
    @Binding var searchResults: [Node]?
    
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
            
            // run search with node name
            Task {
                self.search = node.long_name
                let results = database.searchNodes(query: search)
                self.searchResults = results
            }
        }) {
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
        .buttonStyle(GreyBackgroundButton())
        
    }
    
}

#Preview {
    SearchResult(
        node: Node.example,
        fullscreen: .constant(false),
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil)
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
