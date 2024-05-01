//
//  CartItemsRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import Foundation

extension API {
    static func getCartItems() async throws -> [CartItem] {
        if let data = CART_ITEMS_JSON.data(using: .utf8) {
            print("got cart items from static data")
            return try JSONDecoder().decode([CartItem].self, from: data)
        }
        
        let route = "/api/cart-items"
        guard let url = URL(string: WEBSITE_URL + route) else {
            throw RuntimeError("invalid url")
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        request.httpMethod = "GET"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        do {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 4
            config.timeoutIntervalForResource = 4
            let session = URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
            
            let (data, _) = try await session.data(from: url)
            let items = try JSONDecoder().decode([CartItem].self, from: data)
            print("got cart items from API")
            return items
        }
        catch {
            if let data = CART_ITEMS_JSON.data(using: .utf8) {
                print("got cart items from static data")
                return try JSONDecoder().decode([CartItem].self, from: data)
            }
            throw error
        }
    }
}
