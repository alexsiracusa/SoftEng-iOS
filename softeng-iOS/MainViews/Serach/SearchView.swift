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
    
    var body: some View {
        VStack {
            SearchBar(fullscreen: $fullscreen, focused: _focused, size: 46)
                .padding(.top, 10)
                .padding(.bottom, 15)
                .background(fullscreen ? .white : .clear)
            Spacer()
        }
        .background(fullscreen ? COLOR_BG_P : .clear)
        .ignoresSafeArea(.keyboard)
        .onChange(of: focused) {
            if focused == true {
                fullscreen = true
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
