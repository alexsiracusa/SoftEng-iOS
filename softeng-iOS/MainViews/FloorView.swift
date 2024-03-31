//
//  FloorView.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 3/31/24.
//

import SwiftUI

struct FloorView: View {
    @EnvironmentObject var database: DatabaseEnvironment
    
    var body: some View {
        GeometryReader { proxy in
            Image("00_thelowerlevel1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
}

#Preview {
    FloorView()
        .environmentObject(DatabaseEnvironment())
}
