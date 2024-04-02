//
//  ViewModel.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/1/24.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var floorViews: [FloorData]
    @Published var selectedFloor: FloorData
    
    init() {
        let floor3 = FloorData(floor: .F3, image_name: "03_thethirdfloor")
        let floor2 = FloorData(floor: .F2, image_name: "02_thesecondfloor")
        let floor1 = FloorData(floor: .F1, image_name: "01_thefirstfloor")
        let lower1 = FloorData(floor: .L1, image_name: "00_thelowerlevel1")
        let lower2 = FloorData(floor: .L2, image_name: "00_thelowerlevel2")
        
        self.floorViews = [lower2, lower1, floor1, floor2, floor3]
        self.selectedFloor = floor1
    }
}
