//
//  SearchView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @FocusState private var focused: Bool
    
    @State var lastSearchTime: NSDate = NSDate()
    @State var search = ""
    @State var searchResults: [Node]? = nil
    
    @State var scrolling = false
    @State var scrollTarget: Int? = nil
    
    let detector: CurrentValueSubject<CGFloat, Never>
    let publisher: AnyPublisher<CGFloat, Never>

    init() {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
    }
    
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
                            key: ViewOffsetKey.self,
                            value: -geometry.frame(in: .named("scroll")).origin.y
                        )
                    })
                    .onPreferenceChange(ViewOffsetKey.self) { detector.send($0) }
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ViewOffsetKey.self) { yValue in
                    if (
                        !self.scrolling &&
                        yValue != 0
                    ) {
                        // started scrolling
                        self.scrolling = true
                        focused = false
                    }
                }
                .onReceive(publisher) { _ in
                    // stopped scrolling
                    self.scrolling = false
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

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    SearchView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
