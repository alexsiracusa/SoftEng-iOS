//
//  Loaction.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct Loaction: View {
    let size: CGFloat
    
    var body: some View {
        RoundedButton(
            size: size,
            icon: Image(systemName: "location.north.fill"),
            iconScaleWidth: (1/3),
            iconScaleHeight: (1/3),
            text: "Location",
            textColor: .blue,
            backgroundColor: .blue.opacity(0.1)
        )
    }
}

#Preview {
    Loaction(size: 40)
}
