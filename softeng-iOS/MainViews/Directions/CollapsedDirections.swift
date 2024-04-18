//
//  CollapsedDirections.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/17/24.
//

import SwiftUI

struct CollapsedDirections: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.focusDirections()
            }) {
                Circle()
                    .fill(.white)
                    .shadow(radius: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 18))
                            .bold()
                    )
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: {
                viewModel.sheetHeight = SHEET_LOW
                withAnimation {
                    viewModel.pickDirectionsView = false
                    viewModel.directionInstructions = false
                }
                database.selectedNode = database.pathEnd
                database.resetPath()
            }) {
                Circle()
                    .fill(.white)
                    .shadow(radius: 2)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .bold()
                    )
                    .padding([.leading, .top], 15)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: 42)
        .padding(.horizontal, 8)
        .padding(.top, 10)
    }
}

#Preview {
    CollapsedDirections()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
