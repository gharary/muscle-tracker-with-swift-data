//
//  ChartView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI
import Charts
import SwiftData

struct ChartView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WorkoutType.name) private var workoutTypes: [WorkoutType]
    @State private var pickerSelection: WorkoutType?
}

extension ChartView {
    var body: some View {
        NavigationStack {
            if workoutTypes.isEmpty == true {
                ContentUnavailableView(
                    "No Data",
                    systemImage: "xmark.icloud",
                    description: Text("No workout found!")
                ).navigationTitle("Workouts Chart")
            } else {
                VStack {
                    HStack {
                        Text("Select a workout: ")
                        Picker("", selection: $pickerSelection) {
                            Text("Select a workout").tag(Optional<String>(nil))
                            ForEach(workoutTypes, id: \.self) { workoutType in
                                Text(workoutType.name).tag(workoutType as WorkoutType?)
                            }
                        }.pickerStyle(.menu)
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    if let chartData = workoutTypes.filter({ $0 == pickerSelection }).first?.data.sorted(by: { $0.date < $1.date }), chartData.isEmpty == false {
                        Chart {
                            ForEach(chartData, id: \.self) { workout in
                                LineMark(
                                    x: .value("Date", workout.date, unit: .day),
                                    y: .value("Weight", workout.weight)
                                )
                                .interpolationMethod(.catmullRom)
                                PointMark(
                                    x: .value("Date", workout.date, unit: .day),
                                    y: .value("Weight", workout.weight)
                                )
                                .annotation(position: .overlay,
                                            alignment: .bottom,
                                            spacing: 10) {
                                    Text("\(String(format: "%.2f", workout.weight))")
                                    //                                            .font(.largeTitle)
                                }.foregroundStyle(Color.orange)
                            }
                        }.padding()
                    }
                    else {
                        if pickerSelection == nil {
                            ContentUnavailableView(
                                "No Data",
                                systemImage: "chart.xyaxis.line",
                                description: Text("Please select a workout to see your data")
                            )
                        } else {
                            ContentUnavailableView(
                                "No Data",
                                systemImage: "externaldrive.badge.questionmark",
                                description: Text("You haven't log any data for \(pickerSelection?.name ?? "this") workout")
                            )
                        }
                    }
                }.navigationTitle("Workouts Chart")
                #if DEBUG
                    .onAppear {
                        pickerSelection = workoutTypes.randomElement()
                    }
                #endif
            }
        }
    }
}

#Preview {
    ChartView()
        .modelContainer(previewContainer)
}

