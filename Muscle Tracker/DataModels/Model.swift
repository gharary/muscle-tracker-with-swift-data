//
//  Model.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import Foundation
import SwiftData

typealias WorkoutType = WorkoutSchemaV1.WorkoutType
typealias WorkoutData = WorkoutSchemaV1.WorkoutData

enum WorkoutSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1,0,0)
    
    static var models: [any PersistentModel.Type] {
        [WorkoutData.self, WorkoutType.self]
    }
    
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
}
