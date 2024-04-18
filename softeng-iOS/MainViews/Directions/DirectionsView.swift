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
                
                if let start = database.pathStart {
                    Button(action: {
                        viewModel.jumpToNode(node: start)
                    }) {
                        Image(systemName: "location.circle")
                            .font(.system(size: 22))
                            .bold()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 30)
                } 
                else {
                    Spacer()
                        .frame(width: 30)
                }
                
                Spacer()
                    .frame(width: 15)
                
                if let end = database.pathEnd {
                    Button(action: {
                        viewModel.jumpToNode(node: end)
                    }) {
                        Image(systemName: "arrow.triangle.turn.up.right.circle")
                            .font(.system(size: 22))
                            .bold()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 30)
                }
                else {
                    Spacer()
                        .frame(width: 30)
                }
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
