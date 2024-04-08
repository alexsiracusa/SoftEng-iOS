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
            // TODO
            viewModel.pickDirectionsView.toggle()
            viewModel.sheetHeight = (
                viewModel.pickDirectionsView ? 
                SHEET_MEDIUM : viewModel.sheetHeight
            )
            database.pathEnd = (
                viewModel.pickDirectionsView ?
                node : nil
            )
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
