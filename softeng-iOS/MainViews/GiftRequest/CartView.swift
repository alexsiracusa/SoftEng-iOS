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
                ForEach(database.cart.sorted(by: {$0.key.id > $1.key.id}), id: \.key.id) { item, quantity in
                    CartItemCard(item: item, checkout: true)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
        .customNavigationBar(title: "Cart", next: "Checkout", nextPage: .CHECKOUT)
    }
}
 
#Preview {
    CartView()
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
