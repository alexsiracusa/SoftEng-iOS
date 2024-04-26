//
//  ToIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/26/24.
//

import SwiftUI

struct ToIcon: View {
    let size: CGFloat
    let degrees: CGFloat = 35
    
    var lineWidth: CGFloat {
        return (1/7) * size
    }
    
    var bottomPoint: CGPoint {
        let s = size / 2
        let d = degrees * (Double.pi / 180)
        
        return CGPoint(
            x: 0,
            y: -(s * sin(-d) + (cos(d) / sin(-d)) * s * cos(d))
        )
    }
    
    var center: CGPoint {
        return CGPoint(x: (1/2) * size, y: (1/2) * size)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.red)
                .frame(width: (3/8) * size, height: (3/8) * size)
        }
        .frame(width: size, height: size)
        .overlay(alignment: .center) {
            Path() { path in
                path.addArc(
                    center: center,
                    radius: (1/2) * size - (1/2) * lineWidth,
                    startAngle: .degrees(degrees),
                    endAngle: .degrees(180 - degrees),
                    clockwise: true
                )
                path.addLine(to: bottomPoint + center)
                path.closeSubpath()
            }
            .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineJoin: .round))
        }
    }
}

#Preview {
    ToIcon(size: 160)
}
