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
    
    let nodeSheetHeights = [SHEET_LOW, SHEET_MEDIUM, SHEET_HIGH]
    let directionSheetHeights = [SHEET_LOWEST, SHEET_MEDIUM, SHEET_HIGH]
    @State private var selectedDetent = SHEET_LOW
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            GeometryReader { proxy in
                ZStack {
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
                .navigationDestination(for: SetPath.self) { value in
                    DestinationSearch()
                }
            }
            .sheet(isPresented: $viewModel.presentNodeSheet) {
                Group {
                    if viewModel.pickDirectionsView {
                        DirectionsView()
                            .presentationDetents(
                                Set(directionSheetHeights),
                                selection: $viewModel.sheetHeight
                            )
                    }
                    else {
                        NodeDetail()
                            .presentationDetents(
                                Set(nodeSheetHeights),
                                selection: $viewModel.sheetHeight
                            )
                    }
                }
                .ignoresSafeArea()
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(
                    .enabled(upThrough: SHEET_MEDIUM)
                )
            }
        }
    }
}

#Preview {
    ViewController()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
