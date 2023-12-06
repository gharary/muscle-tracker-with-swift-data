//
//  Model.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import Foundation
import SwiftData

@Model
final class WorkoutData {
    var date: Date
    var weight: Double
    var type: WorkoutType?
    
    init(
        date: Date,
        weight: Double,
        type: WorkoutType
    ) {
        self.date = date
        self.weight = weight
        self.type = type
    }
}


@Model
final class WorkoutType: Hashable {
    var id: UUID
    var name: String
    @Relationship(deleteRule: .cascade,
    inverse: \WorkoutData.type)
    var data: [WorkoutData]
    init(name: String, data: [WorkoutData]) {
        self.id = UUID()
        self.name = name
        self.data = data
    }
}
