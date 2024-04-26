//
//  mapRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/25/24.
//

import Foundation

class API: NSObject, URLSessionTaskDelegate {
    static let delegate = InsecureDelegate()
    
    static func getMap() async throws -> MapResult {
        let route = "/api/map"
        guard let url = URL(string: WEBSITE_URL + route) else {
            throw RuntimeError("invalid url")
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        request.httpMethod = "GET"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        do {
            let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: OperationQueue.main)
            let (data, _) = try await session.data(from: url)
            let map = try JSONDecoder().decode(MapResult.self, from: data)
            return map
        }
        catch {
            throw error
        }
    }
}

class InsecureDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    public func urlSession(_ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
    {
        if challenge.protectionSpace.serverTrust != nil {
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.useCredential, nil)
        }
    }
}





