//
//  GiftRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct GiftRequest: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if let items = database.cartItems {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(items, id: \.id) { item in
                        GiftShopCard(item: item)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.vertical, 10)
            }
            .customNavigationBar(title: "Gift Request", next: "Cart", nextPage: .CART)
        }
        else {
            Text("Loading")
                .onAppear {
                    Task { @MainActor in
                        try? await database.loadCartItems()
                    }
                }
        }
    }
}

#Preview {
    GiftRequest()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
