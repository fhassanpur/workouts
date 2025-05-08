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
    
    @State private var showAddPlanModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workoutPlans) { plan in
                    Text(plan.name)
                }
            }.sheet(isPresented: $showAddPlanModal) {
                CreateWorkoutPlanView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }.toolbar {
                ToolbarItem {
                    let exerciseListView = ExerciseListView().modelContext(modelContext)
                    NavigationLink(destination: exerciseListView) {
                        Text("Exercises")
                    }
                }
                ToolbarItem {
                    Button(action: presentAddPlanModal) {
                        Label("Add Workout Plan", systemImage: "plus")
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
    
    private func presentAddPlanModal() {
        showAddPlanModal = true
    }
}

#Preview {
    WorkoutPlansTabView()
}
