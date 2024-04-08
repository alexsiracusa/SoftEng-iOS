//
//  DestinationSearch.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/8/24.
//

import SwiftUI

struct DestinationSearch: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
            viewModel.sheet = true
        }) {
            Text("Back")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DestinationSearch()
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
