//
//  CartView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Cart")
                
                Button(action: {
                    viewModel.path = NavigationPath()
                }) {
                    Text("Back to root")
                }
            }
        }
        .customNavigationBar(title: "Cart", next: "Checkout", nextPage: .CHECKOUT)
    }
}

#Preview {
    CartView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
