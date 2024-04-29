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
                        CartItemCard(item: item)
                            .padding(.horizontal, 10)
                    }
                }
                .padding(.vertical, 10)
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 15))
                                .bold()
                            Text("Back")
                        }
                    }
                }
                
                ToolbarItem(placement: .principal){
                    HStack {
                        Text("GiftRequest")
                            .font(.headline)
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        // action
                    } label: {
                        HStack {
                            Text("Cart")
                            Image(systemName: "chevron.right")
                                .font(.system(size: 15))
                                .bold()
                        }
                    }
                }
            }
            .tint(COLOR_LOGO_P)
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
    NavigationView {
        GiftRequest()
            .environmentObject(DatabaseEnvironment())
            .environmentObject(ViewModel())
    }
}
