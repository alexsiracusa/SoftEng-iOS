//
//  ViewController.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/1/24.
//

import SwiftUI

struct ViewController: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottomTrailing) {
                FloorView(floor: $viewModel.selectedFloor)
                    .zIndex(0)
                    .ignoresSafeArea()
                FloorSelector(size: 50)
                    .zIndex(1)
                    .padding(.trailing, 25)
                    .padding(.bottom, 40)
                
            }
        }
    }
}

#Preview {
    ViewController()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
