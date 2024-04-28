//
//  CartItem.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import Foundation

struct CartItem: Decodable {
    let id: Int
    let type: String
    let imageURL: String
    let name: String
    let description: String
    let price: String
    
    var priceDouble: Double? {
        return Double(price)
    }
}
