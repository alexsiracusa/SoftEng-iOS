//
//  CartQuantityPicker.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CartQuantityPicker: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let size: CGFloat
    let item: CartItem
    @State var quantity = 1 {
        didSet {
            if quantity == 0 {
                database.removeFromCart(item: item)
            }
            else {
                database.setItemQuantity(item: item, quantity: quantity)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                quantity -= 1
            }) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: (1/2) * size,
                    bottomLeading: (1/2) * size,
                    bottomTrailing: 0,
                    topTrailing: 0),
                                       style: .continuous
                )
                .fill(COLOR_LOGO_T)
                .frame(width: size)
                .overlay(
                    Image(systemName: quantity == 1 ? "trash" : "minus")
                        .font(.system(size: (1/2) * size))
                        .foregroundStyle(.white)
                        .bold()
                        .offset(x: (1/20) * size)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            Rectangle()
                .fill(COLOR_LOGO_T.opacity(0.3))
                .frame(width: (4/3) * size)
                .overlay(
                    TextField("0", value: $quantity, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .font(.system(size: (1/2) * size))
                        .foregroundStyle(.black)
                        .bold()
                        .padding(.horizontal, (1/10) * size)
                )
            
            Button(action: {
                quantity += 1
            }) {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 0,
                    bottomTrailing: (1/2) * size,
                    topTrailing: (1/2) * size),
                                       style: .continuous
                )
                .fill(COLOR_LOGO_T)
                .frame(width: size)
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size: (1/2) * size))
                        .foregroundStyle(.white)
                        .bold()
                        .offset(x: (-1/20) * size)
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(height: size)
        .onAppear() {
            quantity = database.cart[item] ?? 0
        }
    }
}

#Preview {
    CartQuantityPicker(size: 50, item: CART_ITEMS[0])
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
