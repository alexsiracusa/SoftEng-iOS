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
    
    var saved: Bool {
        database.savedLocations.contains(node)
    }
    
    var body: some View {
        Button(action: {
            if saved {
                database.savedLocations.remove(node)
            }
            else {
                database.savedLocations.insert(node)
            }
        }) {
            Save(size: 40, saved: saved)
                .animation(nil, value: UUID())
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
