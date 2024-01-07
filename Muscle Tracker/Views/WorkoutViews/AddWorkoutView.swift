//
//  AddWorkoutView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @FocusState private var isTextfieldFocused: Bool
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [WorkoutType]
    @State private var workoutText: String = ""
    @State private var modifyingItem: WorkoutType? = nil
    @State private var showAlert = false
    var body: some View {
        NavigationStack {
            List {
                TextField("Type workout name. e.g. Deadlift", text: $workoutText)
                    .onSubmit {
                        addItem()
                    }
                    .focused($isTextfieldFocused)
                ForEach(items) { item in
                    Text(item.name)
                        .swipeActions {
                            Button(action: {
                                modifyingItem = item
                                workoutText = item.name
                                isTextfieldFocused.toggle()
                            }, label: {
                                Text("Edit")
                            })
                            Button(action: {
                                modifyingItem = item
                                showAlert.toggle()
                            }, label: {
                                Text("Delete")
                            }).tint(Color.red)
                        }
                }
                .onDelete(perform: deleteItems)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Alert"),
                        message: Text("All your data including all workouts you logged will be lost, are you sure?"),
                        primaryButton: .default(Text("OK")) {
                            deleteItem()
                        },
                        secondaryButton: .cancel {
                            modifyingItem = nil
                        }
                    )
                }
            }
            .navigationTitle("Workout Type List")
        }
    }

    private func addItem() {
        withAnimation {
            guard workoutText.isEmpty == false else { return }
            if let edittingText = modifyingItem {
                let editingItem = items.first(where:  { $0 == edittingText })
                editingItem?.name = workoutText
                workoutText = ""
                modifyingItem = nil
            } else {
                let newItem = WorkoutType(name: workoutText, data: [])
                modelContext.insert(newItem)
                workoutText = ""
            }
        }
    }

    private func deleteItem() {
        if let item = modifyingItem {
            withAnimation {
                modelContext.delete(item)
                modifyingItem = nil
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    AddWorkoutView()
        .modelContainer(previewContainer)
}
