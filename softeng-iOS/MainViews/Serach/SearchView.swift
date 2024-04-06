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
    
    @State var position: CGPoint = CGPoint(x: 0, y: 0)
    @State var scrollTarget: Int? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(
                fullscreen: $fullscreen,
                focused: _focused,
                search: $search,
                searchResults: $searchResults,
                scrollTarget: $scrollTarget,
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
                    ScrollViewReader { value in
                        LazyVStack(spacing: 0) {
                            ForEach(
                                Array(searchResults.enumerated()),
                                id: \.offset
                            ) { index, node in
                                SearchResult(
                                    node: node,
                                    fullscreen: $fullscreen,
                                    focused: _focused
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
        .background(fullscreen ? COLOR_BG_P : .clear)
        .ignoresSafeArea(.keyboard)
        .transition(.opacity)
        .onChange(of: focused) {
            if focused {
                withAnimation {
                    fullscreen = true
                }
            }
            
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
