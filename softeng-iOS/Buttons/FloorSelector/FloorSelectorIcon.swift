//
//  FloorSelectorIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct FloorSelectorIcon: View {
    @Binding var expanded: Bool
    let size: CGFloat
    
    func toggle() {
        withAnimation {
            self.expanded.toggle()
        }
    }
    
    var body: some View {
        Button(action: toggle) {
            RoundedRectangle(cornerRadius: (3/8) * size)
                .fill(COLOR_AC_P)
                .frame(width: size, height: size)
                .overlay(
                    Image(systemName: "square.3.layers.3d")
                        .resizable()
                        .foregroundColor(COLOR_TXT_S)
                        .frame(width: (5/8) * size, height: (5/8) * size)
                )
        }
        .buttonStyle(ScaleButton())
    }
}

#Preview {
    FloorSelectorIcon(expanded: .constant(false), size: 40)
}
