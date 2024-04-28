//
//  websiteURL.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/25/24.
//

import Foundation

let WEBSITE_URL = "https://ec2-18-217-227-54.us-east-2.compute.amazonaws.com"

class API: NSObject, URLSessionTaskDelegate {
    static let delegate = InsecureDelegate()
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
