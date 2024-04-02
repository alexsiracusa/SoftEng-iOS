//
//  FloorIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct FloorIcon: View {
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
            RoundedRectangle(cornerRadius: (3/8) * size)
                .fill(isSelected ? COLOR_AC_S : COLOR_LOGO)
                .stroke(COLOR_LOGO, lineWidth: isSelected ? (1/12) * size : 0)
                .frame(width: size, height: size)
                .overlay(
                    Text(floor.name)
                        .monospaced()
                        .bold()
                        .font(.system(size: (1/2) * size))
                        .foregroundColor(COLOR_TXT_S)
                        .frame(width: size, height: size)
                )
        }
        .buttonStyle(ScaleButton())
    }
}

#Preview {
    FloorIcon(floorIndex: 0, expanded: .constant(false), size: 40)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
