//
//  AddToCartButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct AddToCartButton: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var showAlert = false
    let size: CGFloat
    let item: CartItem
    @State var quantity = 1
    
    var body: some View {
        HStack {
            Menu {
                Picker(selection: $quantity) {
                    ForEach(1...10, id: \.self) { quantity in
                        Text("\(quantity)")
                            .tag(quantity)
                    }
                } label: {}
            } label: {
                HStack {
                    Text("Quantity: \(quantity)")
                        .font(.system(size: (3/8) * size))
                    
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: (3/8) * size))
                }
                .padding(.horizontal, (1/2) * size)
                .padding(.vertical, (5/16) * size)
                .background {
                    RoundedRectangle(cornerRadius: (1/2) * size)
                        .fill(COLOR_LOGO_P)
                        .frame(height: size)
                }
                .foregroundStyle(.white)
            }
            .pickerStyle(.inline)
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                database.addToCart(item: item, quantity: quantity)
                showAlert = true
            }) {
                RoundedButton(
                    size: size,
                    text: "Add Item",
                    textColor: .white,
                    backgroundColor: COLOR_LOGO_P
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Item Added"),
                message: Text("(\(quantity)) \(item.name) has been added to your cart")
            )
        }
    }
}

#Preview {
    AddToCartButton(size: 50, item: CART_ITEMS[0])
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
