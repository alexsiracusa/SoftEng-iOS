//
//  CartItemCard.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct GiftShopCard: View {
    let height: CGFloat
    let item: CartItem
    
    init(
        height: CGFloat = 120,
        item: CartItem
    ) {
        self.height = height
        self.item = item
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: item.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 120)
                    .clipped()
            } placeholder: {
                Color.gray
                    .opacity(0.4)
                    .frame(width: (5/6) * height, height: height)
            }
            .cornerRadius(8)
            
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
                    
                    AddToCartButton(size: 30, item: item)
                }
            }
            .padding(.vertical, 5)
            .padding(.leading, 5)
        }
        .frame(height: height)
    }
}

#Preview {
    GiftShopCard(item: CART_ITEMS[0])
        .padding(.horizontal, 10)
}
