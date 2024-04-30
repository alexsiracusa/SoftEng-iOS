//
//  CartFooter.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CartFooter: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                database.clearCart()
            }) {
                RoundedButton(size: 40, text: "  Clear  ", textColor: .black, backgroundColor: .red.opacity(0.3))
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: {
                viewModel.path.append(Page.CHECKOUT)
            }) {
                RoundedButton(size: 40, text: "  Checkout  ", textColor: .white, backgroundColor: COLOR_LOGO_T)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    CartFooter()
        .environmentObject(DatabaseEnvironment.example!)
        .environmentObject(ViewModel())
}
