//
//  SheetHeights.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import Foundation
import SwiftUI

let BOTTOM_SAFE_AREA = UIApplication.shared.inputView?.window?.safeAreaInsets.bottom ?? 0
private let screenHeight: CGFloat = UIScreen.main.bounds.height - 100 - BOTTOM_SAFE_AREA

let SHEET_LOWEST_CGFLOAT: CGFloat = 50
let SHEET_LOW_CGFLOAT: CGFloat = 100
let SHEET_MEDIUM_CGFLOAT = 0.375 * screenHeight
let SHEET_HIGH_CGFLOAT = 0.99 * screenHeight

let SHEET_LOWEST = PresentationDetent.height(50)
let SHEET_LOW = PresentationDetent.height(100)
let SHEET_MEDIUM = PresentationDetent.fraction(0.375)
let SHEET_HIGH = PresentationDetent.fraction(0.99)

