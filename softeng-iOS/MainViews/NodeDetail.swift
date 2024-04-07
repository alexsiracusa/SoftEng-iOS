//
//  NodeDetail.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/6/24.
//

import SwiftUI

struct NodeDetail: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Text("\(database.selectedNode?.long_name)")
    }
}

#Preview {
    NodeDetail()
}
