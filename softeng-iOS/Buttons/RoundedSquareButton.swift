//
//  RoundedSquareButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct RoundedSquareButton: View {
    let size: CGFloat
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: (3/8) * size)
            .fill(color)
            .frame(width: size, height: size)
    }
}

#Preview {
    RoundedSquareButton(size: 40, color: .blue)
}
