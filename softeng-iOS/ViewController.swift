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
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            GeometryReader { proxy in
                ZStack(alignment: .top) {
                    // Map View
                    FloorView(floor: $viewModel.selectedFloor)
                        .zIndex(0)
                        .offset(y: viewModel.sheet ? -SHEET_LOWEST_CGFLOAT : 0)
                        .ignoresSafeArea()
                    
                    // Directions View
                    if viewModel.pickDirectionsView
                    {
                        if viewModel.directionInstructions &&
                            viewModel.directionsExpanded {
                            DirectionsPicker()
                                .background(
                                    Color.white
                                        .ignoresSafeArea()
                                        .shadow(radius: 3)
                                )
                                .transition(.opacity)
                                .zIndex(2)
                        }
                        else {
                            CollapsedDirections()
                        }
                    }
                    // Search View
                    else {
                        SearchView()
                            .zIndex(2)
                    }
                    
                    // Floor Selector
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            FloorSelector(size: 50)
                                .zIndex(1)
                                .padding(.trailing, 25)
                                .padding(.bottom, 40)
                                .offset(y: viewModel.sheet ? -SHEET_LOW_CGFLOAT : 0)
                        }
                    }
                    .ignoresSafeArea(.keyboard)
                    
                }
                .navigationDestination(for: SetPath.self) { value in
                    DirectionsSearchView(toSet: value)
                }
                .navigationDestination(for: Page.self) { value in
                    switch value {
                    case .GIFT_REQUEST:
                        GiftRequest()
                    case .CART:
                        CartView()
                    case .CHECKOUT:
                        CheckoutView()
                    case .CREDITS:
                        Text("Credits")
                    }
                }
                .toolbar(.hidden)
                
            }
            .sheet(isPresented: $viewModel.presentNodeSheet) {
                Group {
                    if viewModel.directionInstructions {
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
