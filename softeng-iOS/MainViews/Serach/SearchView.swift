//
//  SearchView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @FocusState private var focused: Bool
    @State var fullscreen = false
    
    @State var search = ""
    @State var searchResults: [Node]? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(
                fullscreen: $fullscreen,
                focused: _focused,
                search: $search,
                searchResults: $searchResults,
                size: 46
            )
            .padding(.top, 10)
            .padding(.bottom, 12)
            .background(fullscreen ? .white : .clear)
            .animation(nil, value: UUID())
            
            if searchResults == nil || !fullscreen {
                Spacer()
            }
            
            if let searchResults, fullscreen  {
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(searchResults) { node in
                            SearchResult(node: node)
                        }
                    }
                    .disabled(focused)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    focused = false
                }
            }
        }
        .background(fullscreen ? COLOR_BG_P : .clear)
        .ignoresSafeArea(.keyboard)
        .transition(.opacity)
        .onChange(of: focused) {
            if focused {
                withAnimation {
                    fullscreen = true
                }
            }
            else {
                Task {
                    await runSearch()
                }
            }
            
        }
    }
    
    func runSearch() async {
        if search == "" {
            setSearch(results: [])
        }
        else if search != "" && fullscreen {
            let results = database.searchNodes(query: search)
            setSearch(results: results)
        }
    }
    
    @MainActor
    func setSearch(results: [Node]) {
        self.searchResults = results
    }
}

#Preview {
    SearchView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
