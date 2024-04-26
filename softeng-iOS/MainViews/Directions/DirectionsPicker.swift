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
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                HStack(spacing: 0) {
                    VStack {
                        Button(action: {
                            // collapse view
                            viewModel.directionsExpanded = false
                        }) {
                            Image(systemName: "chevron.backward")
                                .font(.system(size: 18))
                                .bold()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(height: 42)
                        
                        Spacer()
                    }
                    
                    Spacer()
                        .frame(minWidth: 0)
                    
                    ToFromIcon(width: 16)
                }
                .padding(.leading, 20)
                .padding(.trailing, 8)
                .frame(width: 70, height: 95)
                
                VStack(spacing: 10) {
                    Button(action: {
                        viewModel.focusDirections()
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
                        viewModel.focusDirections()
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
                    
                }
                .frame(height: 95)
                
                VStack {
                    Button(action: {
                        // close view
                        viewModel.sheetHeight = SHEET_LOW
                        withAnimation {
                            viewModel.pickDirectionsView = false
                            viewModel.directionInstructions = false
                        }
                        database.selectedNode = database.pathEnd != nil ? database.pathEnd : database.pathStart
                        database.resetPath()
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: 42)
                    
                    Spacer()
                    
                    Button(action: {
                        // swap start and end
                        let start = database.pathStart
                        let end = database.pathEnd
                        
                        database.pathStart = nil
                        database.pathStart = end
                        database.pathEnd = start
                    }) {
                        Image(systemName: "arrow.up.arrow.down")
                            .font(.system(size: 18))
                            .bold()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(height: 42)
                }
                .frame(width: 45, height: 95)
            }
            
            Spacer()
        }
        .padding(.top, 10)
        .frame(height: 140)
    }
}

#Preview {
    DirectionsPicker()
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
