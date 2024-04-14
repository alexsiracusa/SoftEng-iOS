//
//  PathSearchResultButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/14/24.
//

import SwiftUI

struct PathSearchResultButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let node: Node
    @FocusState var focused: Bool
    
    // search data
    @Binding var search: String
    @Binding var searchResults: [Node]?
    
    
    var body: some View {
        Button(action: {
            // TODO
        }) {
            SearchResult(node: node)
        }
        .buttonStyle(GreyBackgroundButton())
        
    }
}

#Preview {
    PathSearchResultButton(
        node: Node.example,
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil)
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
