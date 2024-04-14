//
//  PathSearchView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/14/24.
//

import SwiftUI
import Combine

struct DirectionsSearchView: View {
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
    
    let toSet: SetPath

    init(toSet: SetPath) {
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
        
        self.toSet = toSet
    }
    
    var body: some View {
        VStack(spacing: 0) {
            DirectionsSearchBar(
                focused: _focused,
                search: $search,
                searchResults: $searchResults,
                scrollTarget: $scrollTarget,
                size: 46
            )
            .padding(.top, 10)
            .padding(.bottom, 12)
            .background(.white)
            .animation(nil, value: UUID())
            
            if searchResults == nil {
                Spacer()
            }
            
            if let searchResults  {
                ScrollView {
                    ScrollViewReader { value in
                        LazyVStack(spacing: 0) {
                            ForEach(
                                Array(searchResults.enumerated()),
                                id: \.offset
                            ) { index, node in
                                DirectionsSearchResultButton(
                                    node: node,
                                    focused: _focused,
                                    search: $search,
                                    searchResults: $searchResults,
                                    toSet: toSet
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
        .background(COLOR_BG_P)
        .ignoresSafeArea(.keyboard)
        .transition(.opacity)
        .onChange(of: search) {
            Task {
                await runSearch(time: NSDate())
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func runSearch(time: NSDate) async {
        self.lastSearchTime = time
        if search == "" {
            setSearch(results: [], time: time)
        }
        else if search != "" {
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
    DirectionsSearchView(toSet: .START)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
