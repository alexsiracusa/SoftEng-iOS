//
//  Directions.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct Directions: View {
    let size: CGFloat
    var body: some View {
        RoundedButton(
            size: size,
            icon: Image(systemName: "arrow.triangle.turn.up.right.diamond.fill"),
            iconScaleWidth: (1/2),
            iconScaleHeight: (1/2),
            text: "Directions",
            textColor: .white,
            backgroundColor: .blue
        )
    }
}

#Preview {
    Directions(size: 40)
}
