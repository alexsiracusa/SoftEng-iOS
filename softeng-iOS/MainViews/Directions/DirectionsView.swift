//
//  DirectionsView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/8/24.
//

import SwiftUI

struct DirectionsView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Directions")
                    .font(.title)
                    .bold()
                
                .buttonStyle(PlainButtonStyle())

                Spacer()
            }
            .padding(.top, 20)
        
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .opacity(viewModel.sheetHeight == SHEET_LOWEST ? 0 : 1)
                        .disabled(viewModel.sheetHeight == SHEET_LOWEST)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    DirectionsView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
