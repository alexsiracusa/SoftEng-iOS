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
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        RoundedButton(size: 40, text: "  Cancel  ", textColor: .black, backgroundColor: .red.opacity(0.3))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.path.append(Page.CHECKOUT)
                    }) {
                        RoundedButton(size: 40, text: "  Purchase  ", textColor: .white, backgroundColor: COLOR_LOGO_T)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
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
