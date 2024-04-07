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
    
    @Binding var sheetHeight: PresentationDetent
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            // TODO
            viewModel.pickDirectionsView = true
            sheetHeight = SHEET_LOW
        }) {
            Directions(size: size)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    DirectionsButton(
        sheetHeight: .constant(SHEET_LOW),
        node: Node.example,
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
