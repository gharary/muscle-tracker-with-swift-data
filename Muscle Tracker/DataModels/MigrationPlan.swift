//
//  MigrationPlan.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 07/01/2024.
//

import Foundation
import SwiftData

enum WorkoutTypeMigrationPlan: SchemaMigrationPlan {
    static var schemas: [VersionedSchema.Type] {
        [WorkoutSchemaV1.self, WorkoutSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: WorkoutSchemaV1.self, toVersion: WorkoutSchemaV2.self)
}
