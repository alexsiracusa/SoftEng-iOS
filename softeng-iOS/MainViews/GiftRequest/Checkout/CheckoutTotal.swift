//
//  CartTotal.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CheckoutTotal: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("TOTAL")
                    .font(.title3)
                
                Spacer()
                
                Text("\(database.cartTotal(), specifier: "%.2f")")
                    .font(.title2)
            }
            .padding(.bottom, 10)
            
            HStack {
                Text("Subtotal")
                    .font(.subheadline)
                
                Spacer()
                
                Text("\(database.cartSubTotal(), specifier: "%.2f")")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Shipping")
                    .font(.subheadline)
                
                Spacer()
                
                Text("\(database.cartShipping(), specifier: "%.2f")")
                    .font(.subheadline)
            }
            
            HStack {
                Text("Tax")
                    .font(.subheadline)
                
                Spacer()
                
                Text("\(database.cartTax(), specifier: "%.2f")")
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    CheckoutTotal()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
