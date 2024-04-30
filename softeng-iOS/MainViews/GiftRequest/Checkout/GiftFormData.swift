//
//  GiftFormData.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import Foundation

class GiftFormData: ObservableObject, Encodable {
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
    
    static var example: GiftFormData {
        let data = GiftFormData()
        data.senderName = "Alex"
        data.recipientName = "Wong"
        data.cardNumber = 1234123412341234
        data.cardCVV = 123
        data.cardHolderName = "Alex Siracusa"
        data.cardExpirationDate = "12/31"
        data.items = [-1, -2]
        return data
    }
    
    enum CodingKeys: CodingKey {
        case type, priority, status, locationID, senderName, recipientName, shippingType, cardNumber, cardCVV, cardHolderName, cardExpirationDate, items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(priority, forKey: .priority)
        try container.encode(status, forKey: .status)
        try container.encode(locationID, forKey: .locationID)

        try container.encode(senderName, forKey: .senderName)
        try container.encode(recipientName, forKey: .recipientName)
        try container.encode(shippingType, forKey: .shippingType)
        try container.encode(cardNumber, forKey: .cardNumber)
        try container.encode(cardCVV, forKey: .cardCVV)
        try container.encode(cardHolderName, forKey: .cardHolderName)
        try container.encode(cardExpirationDate, forKey: .cardExpirationDate)
        try container.encode(items, forKey: .items)
    }
}
