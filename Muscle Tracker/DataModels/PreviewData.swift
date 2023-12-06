//
//  PreviewData.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftData
import Foundation

let previewContainer: ModelContainer = {
    let schema = Schema([WorkoutType.self])
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    
    do {
        let container = try ModelContainer(for: schema, configurations: configuration)
        addSampleData(to: container)
        return container
    } catch {
        fatalError("Couldn't create container: \(error.localizedDescription)")
    }
}()

fileprivate func addSampleData(to container: ModelContainer) {
    let workoutType1 = WorkoutType(name: "Deadlift", data: [])
    let workoutType2 = WorkoutType(name: "Bench Press", data: [])
    let workoutType3 = WorkoutType(name: "Shoulder Press", data: [])
    
    Task { @MainActor in
        container.mainContext.insert(workoutType1)
        container.mainContext.insert(workoutType2)
        container.mainContext.insert(workoutType3)
        workoutType1.data = [
            addWorkoutData(for: workoutType1),
            addWorkoutData(for: workoutType1),
            addWorkoutData(for: workoutType1),
            addWorkoutData(for: workoutType1),
            addWorkoutData(for: workoutType1),
            addWorkoutData(for: workoutType1)
        ]
        workoutType2.data = [
            addWorkoutData(for: workoutType2),
            addWorkoutData(for: workoutType2),
            addWorkoutData(for: workoutType2),
            addWorkoutData(for: workoutType2),
            addWorkoutData(for: workoutType2),
            addWorkoutData(for: workoutType2)
        ]
        workoutType3.data = [
            addWorkoutData(for: workoutType3),
            addWorkoutData(for: workoutType3),
            addWorkoutData(for: workoutType3),
            addWorkoutData(for: workoutType3),
            addWorkoutData(for: workoutType3),
            addWorkoutData(for: workoutType3)
        ]
        
        do {
            try container.mainContext.save()
        } catch {
            fatalError("What the heck!")
        }
    }
}

fileprivate func addWorkoutData(for type: WorkoutType) -> WorkoutData {
    let date = randomDateInLast10Days()
    let weight = Double.random(in: 10...20)
    
    return WorkoutData(date: date, weight: weight, type: type)
}

fileprivate func randomDateInLast10Days() -> Date {
    let calendar = Calendar.current
    let currentDate = Date()

    guard let startDate = calendar.date(byAdding: .day, value: -10, to: currentDate) else {
        fatalError("Failed to calculate start date")
    }

    let randomInterval = TimeInterval(arc4random_uniform(UInt32(currentDate.timeIntervalSince(startDate))))
    return startDate.addingTimeInterval(randomInterval)
}
