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
    
    @ObservedObject var formData: GiftFormData
    @State var alertSucess = false
    @State var alertFail = false
    
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
                Task { @MainActor in
                    do {
                        try await API.postGiftRequest(formData: formData)
                        alertSucess = true
                    }
                    catch {
                        alertFail = true
                    }
                }
            }) {
                RoundedButton(
                    size: 40,
                    text: "  Purchase  ",
                    textColor: formData.complete() ? .white : .black,
                    backgroundColor: formData.complete() ? COLOR_LOGO_T : .gray.opacity(0.3)
                )
            }
            .disabled(!formData.complete())
            .buttonStyle(PlainButtonStyle())
            .alert("Order Sent", isPresented: $alertSucess) {
                Button("OK", role: .cancel) {
                    viewModel.path = NavigationPath()
                }
            }
            .alert("Order Failed to Send", isPresented: $alertFail) {
                Button("OK", role: .cancel) {
                    alertFail = false
                }
            }
        }
    }
}

#Preview {
    CheckoutFooter(formData: GiftFormData())
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
