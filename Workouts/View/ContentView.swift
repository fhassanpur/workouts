//
//  ContentView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workoutLogs: [WorkoutLog]

    var body: some View {
        TabView {
            Tab("Logs", systemImage: "dumbbell.fill") {
                WorkoutLogListView().modelContext(modelContext)
            }
            Tab("Workout Plans", systemImage: "checklist") {
                WorkoutPlanListView()
            }
            Tab("Progress", systemImage: "chart.line.uptrend.xyaxis") {
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
