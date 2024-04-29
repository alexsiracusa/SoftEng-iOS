//
//  CustomNavigationBar.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/28/24.
//

import SwiftUI
import Foundation

struct CustomNavigationBar: ViewModifier {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    let title: String
    let next: String?
    let nextPage: Page?
    
    init(
        title: String,
        next: String? = nil,
        nextPage: Page? = nil
    ) {
        self.title = title
        self.next = next
        self.nextPage = nextPage
    }
    
    func body(content: Content) -> some View {
        content
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
                        Text(title)
                            .font(.headline)
                    }
                }
                
                if let next, let nextPage {
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button {
                            viewModel.path.append(nextPage)
                        } label: {
                            HStack {
                                Text(next)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15))
                                    .bold()
                            }
                        }
                    }
                }
            }
            .tint(COLOR_LOGO_P)
    }
}

extension View {
    func customNavigationBar(
        title: String,
        next: String? = nil,
        nextPage: Page? = nil
    ) -> some View {
        modifier(CustomNavigationBar(title: title, next: next, nextPage: nextPage))
    }
}
