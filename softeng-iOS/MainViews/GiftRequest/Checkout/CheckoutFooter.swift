//
//  CheckoutFooter.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct CheckoutFooter: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                RoundedButton(size: 40, text: "  Cancel  ", textColor: .black, backgroundColor: .red.opacity(0.3))
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            Button(action: {
                viewModel.path.append(Page.CHECKOUT)
            }) {
                RoundedButton(size: 40, text: "  Purchase  ", textColor: .white, backgroundColor: COLOR_LOGO_T)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    CheckoutFooter()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
