//
//  FromIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/26/24.
//

import SwiftUI

struct FromIcon: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(.blue, lineWidth: (1/5) * size)
                .frame(width: size, height: size)
                .opacity(0.2)
            Circle()
                .fill(.blue)
                .frame(width: (7/16) * size, height: (7/16) * size)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    FromIcon(size: 160)
}
