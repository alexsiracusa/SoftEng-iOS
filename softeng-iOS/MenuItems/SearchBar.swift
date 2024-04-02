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
    
    @FocusState private var isFocused: Bool
    @State var search: String = ""
    
    let size: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: (1/2) * size)
            .fill(.white)
            .shadow(radius: 3, y: 3)
            .frame(maxWidth: .infinity)
            .frame(height: size)
            .overlay(
                HStack() {
                    Circle()
                        .fill(COLOR_LOGO)
                        .frame(
                            width: (5/7) * size,
                            height: (5/7) * size
                        )
                    TextField("Search here", text: $search)
                        .focused($isFocused)
                        //.foregroundColor(.gray)
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding(5)
            )
            .padding(.horizontal, 20)
            
    }
}

#Preview {
    SearchBar(size: 35)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
