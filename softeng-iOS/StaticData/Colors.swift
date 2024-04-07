//
//  Colors.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

let COLOR_BG_P = Color(hex: 0xf1f1f1)
let COLOR_BG_S = Color(hex: 0xffffff)
let COLOR_BG_T = Color(hex: 0xe4e4e4)

let COLOR_TXT_P = Color(hex: 0x2f2f2f)
let COLOR_TXT_S = Color(hex: 0xffffff)

let COLOR_AC_P = Color(hex: 0x012d5a)
let COLOR_AC_S = Color(hex: 0xf6bd38)

let COLOR_LOGO_P = Color(hex: 0x009ca6)
let COLOR_LOGO_S = Color(hex: 0x003a96)
let COLOR_ICON = Color(hex: 0x6b6d6f)



