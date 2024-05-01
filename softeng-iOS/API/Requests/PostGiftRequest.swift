//
//  PostGiftRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import Foundation

extension API {
    static func postGiftRequest(formData: GiftFormData) async throws {
        let route = "/api/service-requests"
        guard let url = URL(string: WEBSITE_URL + route) else {
            throw RuntimeError("invalid url")
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 1)
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        do {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let encoder = JSONEncoder()
            let data = try encoder.encode(formData)
            //request.httpBody = data
            
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 2
            config.timeoutIntervalForResource = 2
            let session = URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
            
            let (_, response) = try await session.upload(for: request, from: data, delegate: delegate)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print("gift request posted successfully")
                    return
                }
            }
            throw RuntimeError("failed to post gift request")
        }
        catch {
            throw error
        }
    }
}
