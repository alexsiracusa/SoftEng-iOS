//
//  Save.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct Save: View {
    let size: CGFloat
    
    var body: some View {
        RoundedButton(
            size: size,
            icon: Image(systemName: "bookmark"),
            iconScaleWidth: (1/4),
            iconScaleHeight: (1/3),
            text: "Save",
            textColor: .blue,
            backgroundColor: .blue.opacity(0.1)
        )
    }
}

#Preview {
    Save(size: 40)
}
