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
                
                Button(action: {
                    viewModel.jumpToNode(node: database.pathStart)
                }) {
                    Image(systemName: "location.circle")
                        .font(.system(size: 22))
                        .bold()
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(database.pathStart == nil)
                .frame(width: 30)
                
                Spacer()
                    .frame(width: 15)
                
                Button(action: {
                    viewModel.jumpToNode(node: database.pathEnd)
                }) {
                    Image(systemName: "arrow.triangle.turn.up.right.circle")
                        .font(.system(size: 22))
                        .bold()
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(database.pathEnd == nil)
                .frame(width: 30)
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
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
