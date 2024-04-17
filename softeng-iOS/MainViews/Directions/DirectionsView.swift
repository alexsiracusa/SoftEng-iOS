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
        VStack {
            HStack {
                Text("Directions")
                    .font(.title)
                    .bold()

                Spacer()

                Button(action: {
                    // close view
                    viewModel.sheetHeight = SHEET_LOW
                    viewModel.pickDirectionsView = false
                    
                    database.selectedNode = database.pathEnd
                    database.resetPath()
                }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.gray)
                        .bold()
                        .font(.system(size: 6, weight: .regular))
                        .frame(
                            width: 10,
                            height: 10
                        )
                        .background(
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 25, height: 25)
                        )
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        
            ScrollView {
                VStack(alignment: .leading) {
                    DirectionsPicker()
                        .opacity(viewModel.sheetHeight == SHEET_LOWEST ? 0 : 1)
                        .disabled(viewModel.sheetHeight == SHEET_LOWEST)
                }
            }
        }
    }
}

#Preview {
    DirectionsView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
