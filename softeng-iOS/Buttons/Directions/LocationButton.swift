//
//  LocationButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct LocationButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @Binding var sheetHeight: PresentationDetent
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            // TODO
            sheetHeight = SHEET_LOW
            viewModel.setFloor(floor: node.floor)
        }) {
            Loaction(size: 40)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LocationButton(
        sheetHeight: .constant(SHEET_LOW),
        node: Node.example,
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
