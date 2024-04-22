//
//  FloorSelectIcon.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/17/24.
//

import SwiftUI

struct FloorChangeIcon: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    let floor: Floor
    let up: Bool
    let size: CGFloat
    
    var body: some View {
        Button(action: {
            viewModel.setFloor(floor: floor)
        }) {
            Circle()
                .fill(up ? COLOR_AC_S : COLOR_AC_P)
                .frame(width: size, height: size)
                .overlay(
                    Text(floor.name)
                        .monospaced()
                        .bold()
                        .font(.system(size: (1/2) * size))
                        .foregroundColor(up ? .black : COLOR_TXT_S)
                        .frame(width: size, height: size)
                )
                .padding(15)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FloorChangeIcon(floor: .F1, up: true, size: 100)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
