//
//  CartItemCard.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct CartItemCard: View {
    let item: CartItem
    
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
                    .frame(width: 100, height: 120)
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
        .frame(height: 120)
    }
}

#Preview {
    let items = try! JSONDecoder().decode([CartItem].self, from: CART_ITEMS.data(using: .utf8)!)
    return CartItemCard(item: items[0])
        .padding(.horizontal, 10)
}
