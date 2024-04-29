//
//  GiftRequest.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI

struct GiftRequest: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        if let items = database.cartItems {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(items, id: \.id) { item in
                        CartItemCard(item: item)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .navigationTitle("Gift Request")
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
