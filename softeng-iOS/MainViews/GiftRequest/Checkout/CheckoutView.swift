//
//  CheckoutView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                CheckoutTotal()
                    .padding(.bottom, 40)
                
                CheckoutFooter()
            }
            .padding(.horizontal, 25)
        }
        .customNavigationBar(title: "Checkout")
    }
}

#Preview {
    CheckoutView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
