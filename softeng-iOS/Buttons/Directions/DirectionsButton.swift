//
//  DirectionsButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct DirectionsButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            viewModel.focusDirections()
            database.pathStart = nil
            database.pathEnd = node
            database.path = nil
        }) {
            Directions(size: size)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    DirectionsButton(
        node: Node.example,
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
