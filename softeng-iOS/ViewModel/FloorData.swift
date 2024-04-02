//
//  Floor.swift
//  softeng-iOS
//
//  Created by Alex Siracusa on 4/1/24.
//

import Foundation

class FloorData: Identifiable {
    let id = UUID()
    let floor: Floor
    let image_name: String
    
    var name: String {
        return String(describing: floor)
    }
    
    init(floor: Floor, image_name: String) {
        self.floor = floor
        self.image_name = image_name
    }
}
