//
//  CartItemCard.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CartItemCard: View {
    let item: CartItem
    let height: CGFloat
    let checkout: Bool
    
    init(
        item: CartItem,
        height: CGFloat = 120,
        checkout: Bool = false
    ) {
        self.item = item
        self.height = height
        self.checkout = checkout
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (5/6) * height, height: height)
                    .clipped()
            } placeholder: {
                Color.gray
                    .opacity(0.4)
                    .frame(width: (5/6) * height, height: height)
            }
            .clipShape(RoundedRectangle(cornerRadius: checkout ? 0 : 8))
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.name)
                    Text("-")
                    Text("$" + item.price)
                }
                .font(.headline)
                
                Text(item.description)
                    .font(.caption)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    if checkout {
                        CartQuantityPicker(size: 30, item: item)
                    }
                    else {
                        AddToCartButton(size: 30, item: item)
                    }
                }
            }
            .padding(.vertical, 5)
            .padding(.leading, 5)
            .padding(.trailing, checkout ? (1/6) * height : 0)
        }
        .frame(height: height)
        .clipShape(RoundedRectangle(cornerRadius: checkout ? (1/4) * height : 0))
        .background(
            Color.white
                .clipShape(RoundedRectangle(cornerRadius: checkout ? (1/4) * height : 0))
                .shadow(radius: checkout ? 8 : 0)
        )
    }
}

#Preview {
    VStack {
        CartItemCard(item: CART_ITEMS[0])
        CartItemCard(item: CART_ITEMS[1], checkout: true)
        CartItemCard(item: CART_ITEMS[2], checkout: true)
    }
    .padding(.horizontal, 10)
    .environmentObject(DatabaseEnvironment.example!)
    .environmentObject(ViewModel())
}
