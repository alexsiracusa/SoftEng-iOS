//
//  FormField.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/29/24.
//

import SwiftUI

class NoFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        obj as? String
    }

    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        print("in getObjectValue(), string = \(string)")
        obj?.pointee = string as AnyObject
        return true
    }
}

struct FormField: View {
    @FocusState var focused: Bool
    
    @Binding var value: String
    let title: String
    let placeholder: String
    let onChange: ((String) -> String)?
    let onSubmit: ((String) -> String)?
    
    init(
        value: Binding<String>,
        title: String,
        placeholder: String,
        onChange: ((String) -> String)? = nil,
        onSubmit: ((String) -> String)? = nil
    ) {
        _value = value
        self.title = title
        self.placeholder = placeholder
        self.onChange = onChange
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
            
            RoundedRectangle(cornerRadius: 8)
                .stroke( .gray, lineWidth: 1)
                .frame(height: 45)
                .overlay(
                    TextField(placeholder, text: $value)
                        .font(.system(size: 18))
                        .padding(.horizontal, 10)
                        .focused($focused)
                        .onSubmit() {
                            if let onSubmit {
                                value = onSubmit(value)
                            }
                        }
                        .onChange(of: focused) {
                            if let onSubmit {
                                value = onSubmit(value)
                            }
                        }
                        .onChange(of: value) {
                            if let onChange {
                                value = onChange(value)
                            }
                        }
                )
        }
    }
}

#Preview {
    FormField(value: .constant(""), title: "Sender Name", placeholder: "Sender Name")
        .padding(.horizontal, 10)
}
