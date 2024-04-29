//
//  GiftFormData.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import Foundation

class GiftFormData: ObservableObject {
    let type = "GIFT"
    let priority = "LOW"
    let status = "UNASSIGNED"
    let locationID = "WELEV00ML1"
    
    @Published var senderName: String?
    @Published var recipientName: String?
    @Published var shippingType = "STANDARD"
    @Published var cardNumber: Int64!
    @Published var cardCVV: Int!
    @Published var cardHolderName: String!
    @Published var cardExpirationDate: String!
    @Published var items: [Int]!
    
    func complete() -> Bool {
        return (
            senderName != nil &&
            recipientName != nil &&
            cardNumber != nil &&
            cardCVV != nil &&
            cardHolderName != nil &&
            cardExpirationDate != nil &&
            items != nil
        )
    }
}
