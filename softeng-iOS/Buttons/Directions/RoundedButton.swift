//
//  RoundedButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct RoundedButton: View {
    let size: CGFloat
    let icon: Image?
    let iconScaleWidth: CGFloat!
    let iconScaleHeight: CGFloat!
    let text: String
    let textColor: Color
    let backgroundColor: Color
    
    init(
        size: CGFloat,
        icon: Image? = nil,
        iconScaleWidth: CGFloat! = nil,
        iconScaleHeight: CGFloat! = nil,
        text: String,
        textColor: Color,
        backgroundColor: Color
    ) {
        self.size = size
        self.icon = icon
        self.iconScaleWidth = iconScaleWidth
        self.iconScaleHeight = iconScaleHeight
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        HStack(spacing: (1/5) * size) {
            if let icon {
                icon
                    .resizable()
                    .frame(width: iconScaleWidth! * size, height: iconScaleHeight! * size)
                    .foregroundColor(textColor)
            }
            
            Text(text)
                .font(.system(size: (3/8) * size))
                .foregroundColor(textColor)
                .frame(height: size)
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
    VStack {
        RoundedButton(
            size: 40,
            icon: Image(systemName: "arrow.triangle.turn.up.right.diamond.fill"),
            iconScaleWidth: (1/2),
            iconScaleHeight: (1/2),
            text: "Directions",
            textColor: .white,
            backgroundColor: .blue
        )
        RoundedButton(
            size: 40,
            text: "Add Item",
            textColor: .white,
            backgroundColor: .blue
        )
    }
}
