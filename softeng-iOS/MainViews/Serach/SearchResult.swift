//
//  SearchResult.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/2/24.
//

import SwiftUI

struct SearchResult: View {
    @EnvironmentObject var database: DatabaseEnvironment
    @EnvironmentObject var viewModel: ViewModel
    let node: Node
    
    var isSelected: Bool {
        return viewModel.selectedFloor.floor == node.floor
    }
    
    var body: some View {
        HStack(spacing: 0) {
            FloorIcon(
                selected: isSelected,
                name: String(describing: node.floor),
                size: 25
            )
            .padding(.trailing, 7)
            Text("\(node.long_name) (\(node.building))")
            
            Spacer()
            
            Button(action: {
                if database.pathStart?.id == node.id {
                    database.pathStart = nil
                    database.path = nil
                }
                else {
                    database.pathStart = node
                }
            }) {
                Image(systemName: "location.circle")
                    .foregroundColor(
                        database.pathStart?.id ?? "" == node.id ?
                            .blue : .black
                    )
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
                .frame(width: 15)
            
            Button(action: {
                if database.pathEnd?.id == node.id {
                    database.pathEnd = nil
                    database.path = nil
                }
                else {
                    database.pathEnd = node
                }
            }) {
                Image(systemName: "arrow.triangle.turn.up.right.circle")
                    .foregroundColor(
                        database.pathEnd?.id ?? "" == node.id ?
                            .blue : .black
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(.white)
        
    }
    
    
    
}

#Preview {
    SearchResult(node: Node.example)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
