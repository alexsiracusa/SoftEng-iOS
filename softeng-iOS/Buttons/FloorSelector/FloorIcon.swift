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
        RoundedSquareButton(size: size, color: selected ? COLOR_AC_S : COLOR_LOGO_S)
            .overlay(
                Text(name)
                    .monospaced()
                    .bold()
                    .font(.system(size: (1/2) * size))
                    .foregroundColor(selected ? .black : COLOR_TXT_S)
                    .frame(width: size, height: size)
            )
    }
}

#Preview {
    VStack {
        FloorIcon(selected: false, name: "L2", size: 100)
        FloorIcon(selected: true, name: "L2", size: 100)
    }
}
