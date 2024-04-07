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
    
    let heights = [0.1, 0.375, 0.99].map({PresentationDetent.fraction($0)})
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Map View
                FloorView(floor: $viewModel.selectedFloor)
                    .zIndex(0)
                    .offset(y: viewModel.sheet ? -proxy.size.height * 0.1 : 0)
                    .ignoresSafeArea()
                
                // Search and Map Selector
                SearchView()
                    .zIndex(2)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloorSelector(size: 50)
                            .zIndex(1)
                            .padding(.trailing, 25)
                            .padding(.bottom, 40)
                    }
                }
                .offset(y: viewModel.sheet ? -proxy.size.height * 0.1 : 0)
                .ignoresSafeArea(.keyboard)
                
            }
        }
        .sheet(isPresented: $viewModel.presentSheet) {
            NodeDetail()
                .interactiveDismissDisabled()
                .presentationDetents(Set(heights))
                .presentationBackgroundInteraction(
                    .enabled(upThrough: heights[1])
                )
            
        }
    }
}

#Preview {
    ViewController()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
