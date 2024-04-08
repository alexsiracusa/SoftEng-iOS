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
    
    @State var lastSearchTime: NSDate = NSDate()
    @State var search = ""
    @State var searchResults: [Node]? = nil
    
    @State var position: CGPoint = CGPoint(x: 0, y: 0)
    @State var scrollTarget: Int? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(
                focused: _focused,
                search: $search,
                searchResults: $searchResults,
                scrollTarget: $scrollTarget,
                size: 46
            )
            .padding(.top, 10)
            .padding(.bottom, 12)
            .background(viewModel.searchFullscreen ? .white : .clear)
            .animation(nil, value: UUID())
            
            if searchResults == nil || !viewModel.searchFullscreen {
                Spacer()
            }
            
            if let searchResults, viewModel.searchFullscreen  {
                ScrollView {
                    ScrollViewReader { value in
                        LazyVStack(spacing: 0) {
                            ForEach(
                                Array(searchResults.enumerated()),
                                id: \.offset
                            ) { index, node in
                                SearchResult(
                                    node: node,
                                    fullscreen: $viewModel.searchFullscreen,
                                    focused: _focused,
                                    search: $search,
                                    searchResults: $searchResults
                                )
                                .id(index)
                            }
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
                            return viewDimensions[.listRowSeparatorLeading] + 40
                        }
                        .onChange(of: scrollTarget) {
                            if let target = scrollTarget {
                                value.scrollTo(target)
                                scrollTarget = nil
                            }
                        }
                        .onAppear() {
                            scrollTarget = nil
                            value.scrollTo(0)
                        }
                    }
                    .background(GeometryReader { geometry in
                        Color.clear.preference(
                            key: SizingPreferenceKey.self,
                            value: geometry.frame(in: .named("scroll")).origin
                        )
                    })
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(SizingPreferenceKey.self) { position in
                    if self.position != position &&
                        self.position.y != 0 &&
                        position.y != 0
                    {
                        focused = false
                    }
                    self.position = position
                }
                .ignoresSafeArea()
            }
        }
        .background(viewModel.searchFullscreen ? COLOR_BG_P : .clear)
        .ignoresSafeArea(.keyboard)
        .transition(.opacity)
        .onChange(of: focused) {
            if focused {
                withAnimation {
                    viewModel.searchFullscreen = true
                }
            }
        }
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
        else if search != "" && viewModel.searchFullscreen {
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

struct SizingPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint { .zero }
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        // No-op
    }
}

#Preview {
    SearchView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
