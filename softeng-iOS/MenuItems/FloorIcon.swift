//
//  FloorIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct FloorIcon: View {
    let selected: Bool
    let name: String
    let size: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: (3/8) * size)
            .fill(selected ? COLOR_AC_S : COLOR_LOGO)
            .stroke(COLOR_LOGO, lineWidth: selected ? (1/12) * size : 0)
            .frame(width: size, height: size)
            .overlay(
                Text(name)
                    .monospaced()
                    .bold()
                    .font(.system(size: (1/2) * size))
                    .foregroundColor(COLOR_TXT_S)
                    .frame(width: size, height: size)
            )
    }
}

#Preview {
    FloorIcon(selected: false, name: "L2", size: 40)
}
