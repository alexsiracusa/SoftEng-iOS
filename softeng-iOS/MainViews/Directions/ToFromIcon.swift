//
//  ToFromIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/26/24.
//

import SwiftUI

struct ToFromIcon: View {
    let width: CGFloat
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                FromIcon(size: width)
            }
            .frame(maxHeight: .infinity)
            
            HStack(alignment: .center) {
                ToIcon(size: (6/8) * width)
                    .offset(y: -(1/8) * width)
            }
            .frame(maxHeight: .infinity)
        }
        .overlay(alignment: .center) {
            VStack(spacing: (1/6) * width) {
                ForEach(1...3, id: \.self) { _ in
                    Circle()
                        .fill(.black)
                        .frame(width: (1/6) * width, height: (1/6) * width)
                }
            }
        }
        .frame(width: width)
    }
}

#Preview {
    ToFromIcon(width: 80)
        .frame(height: 500)
}
