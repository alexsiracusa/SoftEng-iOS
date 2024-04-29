//
//  CartCheckout.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CartCheckout: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
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
            .padding(.bottom, 40)
            
            HStack {
                Button(action: {
                    
                }) {
                    RoundedButton(size: 40, text: "  Clear  ", textColor: .black, backgroundColor: .red.opacity(0.3))
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    RoundedButton(size: 40, text: "  Clear  ", textColor: .white, backgroundColor: COLOR_LOGO_T)
                }
            }
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    CartCheckout()
        .padding(.horizontal, 20)
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
