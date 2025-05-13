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
            let exercises = plan.exercises.sorted { (lhs, rhs) in
                let lhsIndex = plan.ordering.firstIndex(of: lhs.id)
                let rhsIndex = plan.ordering.firstIndex(of: rhs.id)
                return lhsIndex ?? 0 < rhsIndex ?? 0
                
            }
            List(exercises, id:\.self) { exercise in
                let sets = plan.setCount[exercise.id] ?? 0
                NavigationLink(destination: ExerciseDetailView(exercise: exercise).navigationTitle(exercise.name)) {
                    HStack {
                        Text(exercise.name)
                        Spacer()
                        Image(systemName: "repeat")
                        Text("\(sets)").monospaced()
                    }
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
    let plan = WorkoutPlan(name: "Test Plan", exercises: [exercise], setCounts: [exercise.id:4])
    WorkoutPlanDetailView(plan: plan)
}
