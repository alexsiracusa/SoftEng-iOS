//
//  SearchBar.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @FocusState var focused: Bool
    
    @Binding var search: String
    @Binding var searchResults: [Node]?
    @Binding var scrollTarget: Int?
    
    let size: CGFloat
    
    func clearSearch() {
        self.search = ""
        searchResults = []
    }
    
    func closeView() {
        self.focused = false
        viewModel.searchFullscreen = false
        
        // run search with node name
        Task {
            if let node = database.selectedNode {
                search = node.long_name
                let results = database.searchNodes(query: search)
                self.searchResults = results
            }
        }
    }
    
    func pressXButton() {
        if viewModel.pickDirectionsView {
            database.resetPath()
        }
        database.selectedNode = nil
        viewModel.pickDirectionsView = false
        viewModel.sheetHeight = SHEET_LOW
        withAnimation {
            viewModel.sheet = false
        }
        clearSearch()
    }
    
    func fullscreen() -> Bool {
        return viewModel.searchFullscreen
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: (1/2) * size)
            .fill(.white)
            .stroke(fullscreen() ? .gray : .clear, lineWidth: 0.33)
            .shadow(radius: !fullscreen() ? 3 : 0, y: !fullscreen() ? 3 : 0)
            .frame(maxWidth: .infinity)
            .frame(height: size)
            .overlay(
                HStack() {
                    // Icon
                    HStack {
                        if fullscreen() {
                            Button(action: closeView) {
                                Image(systemName: "chevron.backward")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        else {
                            Button(action: {
                                viewModel.path.append(Page.CREDITS)
                            }) {
                                Image("Brigham_and_Womens_Hospital_Logo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding((3/40) * size)
                                    .padding(.leading, (3/40) * size)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(
                        width: (5/7) * size,
                        height: (5/7) * size
                    )
                    
                    // Search Field
                    TextField("Search here", text: $search)
                        .focused($focused)
                        .font(.system(size: 20))
                    Spacer()
                    
                    // Clear Button
                    if search != "" {
                        HStack {
                            if fullscreen() {
                                Button(action: clearSearch) {
                                    Image(systemName: "xmark.circle")
                                        .resizable()
                                        .font(.system(size: 6, weight: .regular))
                                        .frame(
                                            width: (3/7) * size,
                                            height: (3/7) * size
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            else {
                                Button(action: pressXButton) {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .font(.system(size: 6, weight: .semibold))
                                        .frame(
                                            width: (4/14) * size,
                                            height: (4/14) * size
                                        )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .frame(
                            width: (5/7) * size,
                            height: (5/7) * size
                        )
                        .padding(.trailing, (3/40) * size)
                    }
                    // Gift Request Icon
                    else {
                        Button(action: {
                            viewModel.path.append(Page.GIFT_REQUEST)
                        }) {
                            Image(systemName: "gift.circle")
                                .foregroundColor(COLOR_LOGO_T)
                                .font(.system(size: (5/7) * size))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(
                            width: (5/7) * size,
                            height: (5/7) * size
                        )
                        .padding(.trailing, (2/40) * size)
                    }
                }
                .padding(5)
            )
            .padding(.horizontal, 20)
            
    }
    
}

#Preview {
    SearchBar(
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil), 
        scrollTarget: .constant(0),
        size: 40
    )
    .environmentObject(DatabaseEnvironment.example!)
    .environmentObject(ViewModel())
}
