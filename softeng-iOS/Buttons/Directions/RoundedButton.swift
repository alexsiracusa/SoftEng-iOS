//
//  RoundedButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct RoundedButton: View {
    let size: CGFloat
    let icon: Image
    let iconScaleWidth: CGFloat
    let iconScaleHeight: CGFloat
    let text: String
    let textColor: Color
    let backgroundColor: Color
    
    var body: some View {
        HStack(spacing: (1/5) * size) {
            icon
                .resizable()
                .frame(width: iconScaleWidth * size, height: iconScaleHeight * size)
                .foregroundColor(textColor)
            
            Text(text)
                .font(.system(size: (3/8) * size))
                .foregroundColor(textColor)
        }
        .padding(.horizontal, (1/2) * size)
        .background {
            RoundedRectangle(cornerRadius: (1/2) * size)
                .fill(backgroundColor)
                .frame(height: size)
        }
    }
}

#Preview {
    RoundedButton(
        size: 40,
        icon: Image(systemName: "arrow.triangle.turn.up.right.diamond.fill"),
        iconScaleWidth: (1/2),
        iconScaleHeight: (1/2),
        text: "Directions",
        textColor: .white,
        backgroundColor: .blue
    )
}
