//
//  WorkoutsApp.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI
import SwiftData

@main
struct WorkoutsApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WorkoutLog.self,
            WorkoutExercise.self,
            WorkoutPlan.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }.modelContainer(sharedModelContainer)
    }
}
