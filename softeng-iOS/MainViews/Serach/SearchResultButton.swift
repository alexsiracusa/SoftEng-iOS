//
//  SearchResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchResultButton: View {
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
            SearchResult(node: node)
        }
        .buttonStyle(GreyBackgroundButton())
        
    }
    
}

#Preview {
    SearchResultButton(
        node: Node.example,
        fullscreen: .constant(false),
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil)
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
