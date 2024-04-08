//
//  DirectionsPicker.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/7/24.
//

import SwiftUI

struct DirectionsPicker: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var startText: String {
        if let start = database.pathStart {
            return start.long_name
        }
        else {
            return "Input Your Location"
        }
    }
    
    var endText: String {
        if let end = database.pathEnd {
            return end.long_name
        }
        else {
            return "Destination"
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                
            }
            .frame(width: 50)
            
            VStack(spacing: 10) {
                Button(action: {
                    viewModel.sheet = false
                    viewModel.path.append(SetPath.START)
                }) {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.gray, lineWidth: 1)
                        .frame(height: 42)
                        .overlay(
                            HStack(spacing: 0) {
                                Text(startText)
                                    .lineLimit(1)
                                    .foregroundColor(Color(UIColor.darkGray))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                    
                Button(action: {
                    viewModel.sheet = false
                    viewModel.path.append(SetPath.END)
                }) {
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.gray, lineWidth: 1)
                        .frame(height: 42)
                        .overlay(
                            HStack(spacing: 0) {
                                Text(endText)
                                    .lineLimit(1)
                                    .foregroundColor(Color(UIColor.darkGray))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                        )
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
            }
            .padding(.top, 10)
            
            VStack {
                
            }
            .frame(width: 50)
        }
    }
}

#Preview {
    DirectionsPicker()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
