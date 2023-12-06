//
//  TabView.swift
//  Muscle Tracker
//
//  Created by Mo Personal on 06/12/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            ChartView()
                .tabItem {
                    Label("Workout Progress", systemImage: "chart.xyaxis.line")
                }
                .tag(0)
            WorkoutListView()
                .tabItem {
                    Label("Workout Data", systemImage: "pencil.and.list.clipboard")
                }
                .tag(1)
                .navigationTitle("ChartSelection")
        }
    }
}

#Preview {
    TabBarView()
}
