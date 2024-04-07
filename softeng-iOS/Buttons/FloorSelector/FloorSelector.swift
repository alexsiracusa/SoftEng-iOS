//
//  FloorSelector.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/1/24.
//

import SwiftUI

struct FloorSelector: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var expanded = false
    let size: CGFloat
    
    func toggle() {
        withAnimation {
            self.expanded.toggle()
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(
                Array(self.viewModel.floorViews.enumerated()),
                id: \.offset
            )
            { index, floor in
                FloorIconButton(floorIndex: index, expanded: $expanded, size: size)
                    .animation(.spring(duration: 0.3), value: expanded)
                    .zIndex(-Double(index))
                    .offset(
                        y: expanded ? -((9/8) * size) * CGFloat(index + 1) : 0
                    )
                    .animation(nil, value: UUID())
                    .opacity(expanded ? 1 : 0)
            }
            FloorSelectorIcon(expanded: $expanded, size: size)
            .zIndex(99)
        }
    }
}

#Preview {
    FloorSelector(size: 60)
        .environmentObject(DatabaseEnvironment())
        .environmentObject(ViewModel())
}
