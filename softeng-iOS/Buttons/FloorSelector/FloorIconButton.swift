//
//  FloorIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct FloorIconButton: View {
    @EnvironmentObject var viewModel: ViewModel
    let floorIndex: Int
    @Binding var expanded: Bool
    let size: CGFloat
    
    var floor: FloorData {
        return viewModel.floorViews[floorIndex]
    }
    
    var isSelected: Bool {
        return viewModel.selectedFloor.id == floor.id
    }
    
    func setFloor() {
        viewModel.selectedFloor = viewModel.floorViews[floorIndex]
        withAnimation {
            self.expanded = false
        }
    }
    
    var body: some View {
        Button(action: setFloor) {
            FloorIcon(selected: isSelected, name: floor.name, size: size)
        }
        .buttonStyle(ScaleButton())
    }
}

#Preview {
    FloorIconButton(floorIndex: 0, expanded: .constant(false), size: 40)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
