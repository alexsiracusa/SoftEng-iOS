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
    
    let heights = [SHEET_LOW, SHEET_MEDIUM, SHEET_HIGH]
    @State private var selectedDetent = SHEET_LOW
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                
                if viewModel.pickDirectionsView {
                    VStack {
                        DirectionsPicker()
                        
                        Spacer()
                    }
                    .zIndex(3)
                }
                
                // Map View
                FloorView(floor: $viewModel.selectedFloor)
                    .zIndex(0)
                    .offset(y: viewModel.sheet ? -proxy.size.height * 0.1 : 0)
                    .ignoresSafeArea()
                
                // Search View
                SearchView()
                    .zIndex(2)
                
                // Floor Selector
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
                .offset(y: viewModel.sheet ? -proxy.size.height * 0.12 : 0)
                .ignoresSafeArea(.keyboard)
                
            }
        }
        .sheet(isPresented: $viewModel.presentSheet) {
            NodeDetail(height: $selectedDetent)
                .ignoresSafeArea()
                .interactiveDismissDisabled()
                .presentationDetents(
                    Set(heights),
                    selection: $selectedDetent
                )
                .presentationBackgroundInteraction(
                    .enabled(upThrough: SHEET_MEDIUM)
                )
                
            
        }
    }
}

#Preview {
    ViewController()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
