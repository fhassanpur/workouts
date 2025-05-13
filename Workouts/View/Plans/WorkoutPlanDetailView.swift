//
//  WorkoutPlanDetailView.swift
//  Workouts
//
//  Created by Ferdows on 5/12/25.
//

import SwiftUI

struct WorkoutPlanDetailView: View {
    var plan: WorkoutPlan
    
    var body: some View {
        VStack {
            List(plan.exercises, id:\.self) { exercise in
                let sets = plan.setCount[exercise.id.hashValue] ?? 0
                NavigationLink(destination: ExerciseDetailView(exercise: exercise).navigationTitle(exercise.name)) {
                    Text("\(sets) sets of \(exercise.name)")
                }
            }
            Button("Start Workout") {
                
            }
            .font(.title3)
            .bold()
            .padding()
        }
    }
}

#Preview {
    let exercise = WorkoutExercise(name: "Barbell Bench Press", type: .strength)
    let plan = WorkoutPlan(name: "Test Plan", exercises: [exercise], setCounts: [exercise.id.hashValue:4])
    WorkoutPlanDetailView(plan: plan)
}
