//
//  Item.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
