//
//  PathSearchResultButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/14/24.
//

import SwiftUI

struct DirectionsSearchResultButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    let node: Node
    @FocusState var focused: Bool
    
    // search data
    @Binding var search: String
    @Binding var searchResults: [Node]?
    
    let toSet: SetPath
    
    var body: some View {
        Button(action: {
            // set either end or start node
            switch toSet {
            case .START:
                database.pathStart = node
                viewModel.setFloor(floor: node.floor)
            case.END:
                database.pathEnd = node
                database.selectedNode = node
                viewModel.setFloor(floor: node.floor)
            }
            
            // close view
            dismiss()
            viewModel.sheet = true
            
            // jump to start if path is complete
            if let _ = database.path, let floor = database.pathStart?.floor {
                viewModel.setFloor(floor: floor)
                viewModel.directionsExpanded = false
            }
        }) {
            SearchResult(node: node)
        }
        .buttonStyle(GreyBackgroundButton())
        
    }
}

#Preview {
    DirectionsSearchResultButton(
        node: Node.example,
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil),
        toSet: .START
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
