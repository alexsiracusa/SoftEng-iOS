//
//  SaveButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct SaveButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let node: Node
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            // TODO
        }) {
            Save(size: 40)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SaveButton(
        node: Node.example,
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
