//
//  CheckoutForm.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

enum ShippingType: String {
    case STANDARD = "STANDARD"
    case EXPRESS = "EXPRESS"
}

struct CheckoutForm: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @ObservedObject var formData: GiftFormData
    
    @State var senderName: String = ""
    @State var recipientName: String = ""
    @State var cardNumber: String = ""
    @State var cardCVV: String = ""
    @State var cardHolderName: String = ""
    @State var cardExpirationDate: String = ""
    @State var shippingType: ShippingType = .STANDARD
    
    func formatNumber(value: String) -> String {
        return value.filter("0123456789".contains)
    }
    
    // Card Number Formatting
    func formatCardNumber(value: String) -> String {
        return String(formatNumber(value: value).prefix(16))
    }
    
    func submitCardNumber(value: String) -> String {
        var num = formatCardNumber(value: value)
        num = num.count == 16 ? num : ""
        formData.cardNumber = num == "" ? nil : Int64(num)
        return num
    }
    
    // CVV Formatting
    func formatCVV(value: String) -> String {
        return String(formatNumber(value: value).prefix(3))
    }
    
    func submitCVV(value: String) -> String {
        var cvv = formatCVV(value: value)
        cvv = cvv.count == 3 ? cvv : ""
        formData.cardCVV = cvv == "" ? nil : Int(cvv)
        return cvv
    }
    
    // Date Formatting
    func formatDate(value: String) -> String {
        return value.filter("0123456789/".contains)
    }
    
    func submitDate(value: String) -> String {
        let filtered = formatDate(value: value)
        let parts = filtered.split(separator: "/")
        if 
            parts.count >= 2,
            let month = Int(parts[0]), 
            let day = Int(parts[1])
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd"
            if let _ = formatter.date(from: "\(month)/\(day)") {
                let date = "\(month)/\(day)"
                formData.cardExpirationDate = date
                return date
            }
        }
        
        formData.cardExpirationDate = nil
        return ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            FormField(
                value: $senderName,
                title: "Sender Name*",
                placeholder: "Sender Name",
                onSubmit: { value in
                    formData.senderName = value == "" ? nil : value
                    return value
                }
            )
            FormField(
                value: $recipientName,
                title: "Recipient Name*",
                placeholder: "Recipient Name",
                onSubmit: { value in
                    formData.recipientName = value == "" ? nil : value
                    return value
                }
            )
            
            HStack {
                FormField(
                    value: $cardNumber,
                    title: "Card Number*",
                    placeholder: "0000 0000 0000 0000",
                    onChange: formatCardNumber,
                    onSubmit: submitCardNumber
                )
                
                Spacer()
                
                FormField(
                    value: $cardCVV,
                    title: "CVV*",
                    placeholder: "000",
                    onChange: formatCVV,
                    onSubmit: submitCVV
                )
                .frame(width: 55)
            }
            
            HStack {
                FormField(
                    value: $cardHolderName,
                    title: "Card Holder*",
                    placeholder: "Card Holder Name",
                    onSubmit: { value in
                        formData.cardHolderName = value == "" ? nil : value
                        return value
                    }
                )
                
                Spacer()
                
                FormField(
                    value: $cardExpirationDate,
                    title: "Exp. *",
                    placeholder: "00/00",
                    onChange: formatDate,
                    onSubmit: submitDate
                )
                .frame(width: 70)
            }
        }
    }
}

#Preview {
    CheckoutForm(formData: GiftFormData())
        .padding(.horizontal, 20)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
