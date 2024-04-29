//
//  CheckoutForm.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CheckoutForm: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    @State var senderName: String = ""
    @State var recipientName: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Sender Name")
                    .font(.subheadline)
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke( .gray, lineWidth: 1)
                    .frame(height: 45)
                    .overlay(
                        TextField("Sender Name", text: $senderName)
                            .font(.system(size: 18))
                            .padding(.horizontal, 10)
                    )
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Recipient Name")
                    .font(.subheadline)
                
                RoundedRectangle(cornerRadius: 8)
                    .stroke( .gray, lineWidth: 1)
                    .frame(height: 45)
                    .overlay(
                        TextField("Recipient Name", text: $recipientName)
                            .font(.system(size: 18))
                            .padding(.horizontal, 10)
                    )
            }
        }
    }
}

#Preview {
    CheckoutForm()
        .padding(.horizontal, 20)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
