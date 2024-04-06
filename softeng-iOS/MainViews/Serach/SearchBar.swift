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
    
    @Binding var fullscreen: Bool
    @FocusState var focused: Bool
    
    @State var lastSearchTime: NSDate = NSDate()
    @Binding var search: String
    @Binding var searchResults: [Node]?
    @Binding var scrollTarget: Int?
    
    let size: CGFloat
    
    func clearSearch() {
        self.search = ""
        searchResults = []
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: (1/2) * size)
            .fill(.white)
            .stroke(fullscreen ? .gray : .clear, lineWidth: 0.33)
            .shadow(radius: !fullscreen ? 3 : 0, y: !fullscreen ? 3 : 0)
            .frame(maxWidth: .infinity)
            .frame(height: size)
            .overlay(
                HStack() {
                    // Icon
                    HStack {
                        if fullscreen {
                            Button(action: {
                                self.focused = false
                                self.fullscreen = false
                            }) {
                                Image(systemName: "chevron.backward")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        else {
                            Image("Brigham_and_Womens_Hospital_Logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding((3/40) * size)
                                .padding(.leading, (3/40) * size)
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
                            if fullscreen {
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
                                Button(action: clearSearch) {
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
                }
                .padding(5)
            )
            .padding(.horizontal, 20)
            .onChange(of: search) {
                Task {
                    await runSearch(time: NSDate())
                }
            }
            
    }
    
    func runSearch(time: NSDate) async {
        self.lastSearchTime = time
        if search == "" {
            setSearch(results: [], time: time)
        }
        else if search != "" && fullscreen {
            let results = database.searchNodes(query: search)
            setSearch(results: results, time: time)
        }
    }
    
    @MainActor
    func setSearch(results: [Node], time: NSDate) {
        if lastSearchTime == time {
            scrollTarget = 0
            self.searchResults = results
        }
    }
    
}

#Preview {
    SearchBar(
        fullscreen: .constant(false),
        focused: FocusState<Bool>(),
        search: .constant(""),
        searchResults: .constant(nil), 
        scrollTarget: .constant(0),
        size: 40
    )
    .environmentObject(DatabaseEnvironment())
    .environmentObject(ViewModel())
}
