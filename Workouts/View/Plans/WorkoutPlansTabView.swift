//
//  WorkoutPlansTabView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI
import SwiftData

struct WorkoutPlansTabView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var workoutPlans: [WorkoutPlan]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutPlans) { plan in
                    NavigationLink(destination: WorkoutPlanDetailView(plan: plan).navigationTitle(plan.name)) {
                        Text(plan.name)
                    }
                }
            }.toolbar {
                ToolbarItem {
                    let exerciseListView = ExerciseListView(isSelectMode: false).modelContext(modelContext)
                    NavigationLink(destination: exerciseListView) {
                        Text("Exercises")
                    }
                }
                ToolbarItem {
                    let createView = CreateWorkoutPlanView().modelContext(modelContext)
                        .navigationTitle("Create Workout Plan")
                    NavigationLink(destination: createView) {
                        Text("Add")
                    }
                }
            }.overlay {
                if workoutPlans.isEmpty {
                    ContentUnavailableView {
                        Label("No workout plans.", systemImage: "checklist")
                    } description: {
                        Text("Add a workout plan to see it here.")
                    }
                }
            }.navigationTitle("Plans")
        }
    }
}

#Preview {
    WorkoutPlansTabView()
}
