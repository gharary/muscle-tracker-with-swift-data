//
//  WorkoutListView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \WorkoutType.name) private var workoutTypes: [WorkoutType]
    @State private var isAddingData: Bool = false
    @State private var searchText: String = ""
    var body: some View {
        NavigationStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingData = true
                    } label: {
                        Label("Add Data", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Workout Types")
            .searchable(text: $searchText)
        }
        .sheet(isPresented: $isAddingData) {
            AddWorkoutView()
        }
    }
    
    var searchResults: [WorkoutType] {
        if searchText.isEmpty {
            return workoutTypes
        } else {
            return workoutTypes.filter { $0.name.contains(searchText) }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if workoutTypes.isEmpty == true {
            ContentUnavailableView(
                "No Data",
                systemImage: "externaldrive.badge.questionmark",
                description: Text("You haven't log any data for this workout, Click the '+' button above, and add some data!")
            )
        } else {
            List {
                ForEach(searchResults) { workout in
                    NavigationLink(workout.name) {
                        WorkoutDetailView(workoutType: workout)
                    }
                }.onDelete(perform: { indexSet in
                    if let selection = indexSet.first {
                        context.delete(workoutTypes[selection])
                    }
                })
            }
        }
    }
}



#Preview {
    WorkoutListView()
        .modelContainer(previewContainer)
}
