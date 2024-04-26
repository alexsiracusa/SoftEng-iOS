//
//  FloorOffsets.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/26/24.
//

import Foundation

extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

let FLOOR_OFFSETS: [Floor : CGPoint] = [
    Floor.F3: CGPoint(x: 0, y: 0),
    Floor.F2: CGPoint(x: 0, y: 0),
    Floor.F1: CGPoint(x: 0, y: 0),
    Floor.L1: CGPoint(x: 20, y: 3),
    Floor.L2: CGPoint(x: 45, y: -20)
]
