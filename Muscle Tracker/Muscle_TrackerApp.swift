//
//  Muscle_TrackerApp.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import SwiftData

@main
struct Muscle_TrackerApp: App {
    let modelContainer: ModelContainer
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(modelContainer)
    }
    
    init() {
        #if DEBUG
        modelContainer = previewContainer
        #else
        do {
            let schema = Schema([
                WorkoutData.self
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: schema, migrationPlan: WorkoutTypeMigrationPlan.self, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        #endif
    }
}
