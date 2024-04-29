//
//  AddToCartButton.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct AddToCartButton: View {
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
    }
}

#Preview {
    let items = try! JSONDecoder().decode([CartItem].self, from: CART_ITEMS.data(using: .utf8)!)
    
    return AddToCartButton(size: 50, item: items[0])
}
