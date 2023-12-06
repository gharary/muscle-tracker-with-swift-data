//
//  WorkoutDetailView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var context
    @State private var isAddingData: Bool = false
    @Bindable var workoutType: WorkoutType

    var body: some View {
            List {
                if (workoutType.data.isEmpty == false) {
                    Section("Data") {
                        ForEach(workoutType.data) { data in
                                VStack(alignment: .leading) {
                                    Text("Weight: \(String(format: "%.2f",data.weight)) kg")
                                    Text("Date: \(data.date.formatted(date: .abbreviated, time: .omitted))")
                                        .foregroundStyle(Color.accentColor)
                                }
                            
                        }.onDelete { indexSet in
                            if let selection = indexSet.first {
                                context.delete(workoutType.data[selection])
                            }
                        }
                    }
                } else {
                    ContentUnavailableView(
                        "No Data",
                        systemImage: "externaldrive.badge.questionmark",
                        description: Text("You haven't log any data for this workout, Click '+' button to add some")
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingData = true
                    } label: {
                        Label("Add Data", systemImage: "plus")
                    }
                }
            }
    }
}
#Preview {
    WorkoutDetailView(workoutType: WorkoutType(name: "Deadlift", data: []))
        .modelContainer(previewContainer)
}
