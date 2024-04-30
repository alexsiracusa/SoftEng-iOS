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
    
    @ObservedObject var formData = GiftFormData()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                CheckoutForm(formData: formData)
                
                CheckoutTotal()
                
                CheckoutFooter(formData: formData)
            }
            .padding(.horizontal, 25)
        }
        .customNavigationBar(title: "Checkout")
        .onAppear {
            var items = [Int]()
            for (item, quantity) in database.cart {
                for _ in 1...quantity {
                    items.append(item.id)
                }
            }
            formData.items = items
        }
    }
}

#Preview {
    CheckoutView()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
