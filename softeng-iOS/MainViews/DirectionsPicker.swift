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
    
    var body: some View {
        HStack {
            VStack {
                
            }
            .frame(width: 50)
            
            VStack(spacing: 10) {
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 1)
                    .frame(height: 42)
                    .overlay(
                        HStack(spacing: 0) {
                            Text("Your Location")
                                .foregroundColor(Color(UIColor.darkGray))
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                    )
                
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.gray, lineWidth: 1)
                    .frame(height: 42)
                    .overlay(
                        HStack(spacing: 0) {
                            Text("Destination")
                                .foregroundColor(Color(UIColor.darkGray))
                            Spacer()
                        }
                        .padding(.horizontal, 10)
                    )
                
                Spacer()
            }
            .padding(.top, 10)
            .frame(height: 150)
            
            VStack {
                
            }
            .frame(width: 50)
        }
        .frame(height: 150)
        .background(
            Color.white
                .ignoresSafeArea()
                .shadow(radius: 3)
        )
    }
}

#Preview {
    DirectionsPicker()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
