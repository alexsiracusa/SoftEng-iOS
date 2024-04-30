//
//  Save.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct Save: View {
    let size: CGFloat
    let saved: Bool
    
    var body: some View {
        RoundedButton(
            size: size,
            icon: Image(systemName: saved ? "checkmark.circle" : "bookmark"),
            iconScaleWidth: saved ? (1/3) : (1/4),
            iconScaleHeight: saved ? (1/3) : (1/3),
            text: saved ? "Saved" : "Save",
            textColor: .blue,
            backgroundColor: .blue.opacity(0.1)
        )
    }
}

#Preview {
    Save(size: 40, saved: false)
}
