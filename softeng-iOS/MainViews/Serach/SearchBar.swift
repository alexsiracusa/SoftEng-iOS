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
    @State var search: String = ""
    
    let size: CGFloat
    
    func close() {
        self.focused = false
        self.fullscreen = false
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
                            Button(action: close) {
                                Image(systemName: "chevron.backward")
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        else {
                            Circle()
                                .fill(COLOR_LOGO)
                        }
                    }
                    .frame(
                        width: (5/7) * size,
                        height: (5/7) * size
                    )
                    
                    // Search Field
                    TextField("Search here", text: $search)
                        .focused($focused)
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
    SearchBar(fullscreen: .constant(false), focused: FocusState<Bool>(), size: 40)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
