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

    var body: some View {
        TabView {
            Tab("Home", systemImage: "dumbbell.fill") {
                HomeTabView()
            }
            Tab("Workout Plans", systemImage: "checklist") {
                WorkoutPlansTabView().modelContext(modelContext)
            }
            Tab("Progress", systemImage: "chart.line.uptrend.xyaxis") {
                ProgressTabView().modelContext(modelContext)
            }
        }.onAppear {
            let descriptor = FetchDescriptor<WorkoutExercise>()
            let count = try! modelContext.fetchCount(descriptor)
            if count == 0 {
                DataMigration.migrateJsonData(modelContext)
            }
        }
    }
}

#Preview {
    ContentView()
}
