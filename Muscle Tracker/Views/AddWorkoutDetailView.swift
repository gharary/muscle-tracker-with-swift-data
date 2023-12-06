//
//  AddWorkoutDetailView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import SwiftData

struct AddWorkoutDetailView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var weight: Double?
    @State private var date: Date = .now
    let workoutType: WorkoutType
    @State private var showAlert: Bool = false
    @State private var errorMessage: String = ""
    @Binding var dismiss: Bool
    
}

extension AddWorkoutDetailView {
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Text("Workout Type")
                        Spacer()
                        Text(workoutType.name).bold()//.padding(5).border(Color.black)
                        Spacer()
                    }
                    
                    HStack {
                        Text("Weight")
                        TextField("Enter weight e.g. 1,5 ", value: $weight, format: .number)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack {
                        Text("Date")
                        DatePicker("", selection: $date, displayedComponents: .date)
                            .datePickerStyle(.compact)
                    }
                }
                Button("Save") {
                    guard let weight = weight else {
                        errorMessage = "Weight is empty or incorrect! Please check!"
                        showAlert.toggle()
                        return
                    }
                    
                    addItem(weight: weight)
                    
                }.buttonStyle(.borderedProminent)
                    .alert(isPresented: $showAlert, content: {
                        Alert(
                            title: Text("Error"),
                            message: Text(errorMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    })
                Spacer()
            }.padding()
                .navigationTitle("Enter Workout Data")
        }
    }
}

extension AddWorkoutDetailView {
    private func addItem(weight: Double) {
        let newItem = WorkoutData(date: date, weight: weight, type: workoutType)
        workoutType.data.append(newItem)
        modelContext.insert(newItem)
        dismiss.toggle()
    }
}

#Preview {
    AddWorkoutDetailView(workoutType: .init(name: "KickBoxing", data: []), dismiss: .constant(false))
}

