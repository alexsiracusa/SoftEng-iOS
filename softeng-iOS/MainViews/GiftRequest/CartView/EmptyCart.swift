//
//  EmptyCart.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

struct EmptyCart: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Image("EmptyCart")
                .resizable()
                .scaledToFit()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                RoundedButton(size: 50, text: "Back", textColor: .white, backgroundColor: COLOR_LOGO_T)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    EmptyCart()
}
