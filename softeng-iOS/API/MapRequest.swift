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
    //    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
    //       //Trust the certificate even if not valid
    //       let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
    //
    //       completionHandler(.useCredential, urlCredential)
    //    }
    
//    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
//    }
    
//    func urlSession(_ session: URLSession,
//            didReceive challenge: URLAuthenticationChallenge,
//            completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)
//        {
//        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//            if let certFile = Bundle.main.path(forResource: "my-cert", ofType: "cer"),
//                let data = try? Data(contentsOf: URL(fileURLWithPath: certFile)),
//                let cert = SecCertificateCreateWithData(nil, data as CFData),
//                let trust = challenge.protectionSpace.serverTrust
//            {
//                SecTrustSetAnchorCertificates(trust, [cert] as CFArray)
//                completionHandler(.useCredential, URLCredential(trust: trust))
//            } else {
//                completionHandler(.cancelAuthenticationChallenge, nil)
//            }
//        }
//    }
    
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





