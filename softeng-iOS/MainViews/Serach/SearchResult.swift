//
//  SearchResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchResult: View {
    let node: Node
    
    var body: some View {
        HStack {
            Text("\(node.long_name) \(node.floor) \(node.building)")
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        .background(.white)
    }
}

#Preview {
    SearchResult(node: Node.example)
}
