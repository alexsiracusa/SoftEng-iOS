//
//  CartItemsRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import Foundation

extension API {
    static func getCartItems() async throws -> [CartItem] {
        do {
            if let data = CART_ITEMS.data(using: .utf8) {
                return try JSONDecoder().decode([CartItem].self, from: data)
            }
            else {
                throw RuntimeError("json parsing from CART_ITEMS went wrong")
            }
        }
        catch {
            throw error
        }
    }
}
