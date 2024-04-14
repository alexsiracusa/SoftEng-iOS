//
//  PathSearchBar.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/13/24.
//

import SwiftUI

struct PathSearchBar: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
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
        dismiss()
        viewModel.sheet = true
    }
    
    func pressXButton() {
        clearSearch()
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: (1/2) * size)
            .fill(.white)
            .stroke(.gray, lineWidth: 0.33)
            .frame(maxWidth: .infinity)
            .frame(height: size)
            .overlay(
                HStack() {
                    // Icon
                    HStack {
                        Button(action: closeView) {
                            Image(systemName: "chevron.backward")
                        }
                        .buttonStyle(PlainButtonStyle())
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
                        .frame(
                            width: (5/7) * size,
                            height: (5/7) * size
                        )
                        .padding(.trailing, (3/40) * size)
                    }
                }
                .padding(5)
            )
            .padding(.horizontal, 20)
            
    }
}

#Preview {
    PathSearchBar(
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil),
        scrollTarget: .constant(0),
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
