//
//  CreateWorkoutPlanView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI

struct CreateWorkoutPlanView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var exercises: [WorkoutExercise] = []
    
    @State private var showExercisesList = false
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .limitInputLength(value: $name, length: 50)
                .padding(.horizontal)
            
            NavigationStack {
                List {
                    Section {
                        ForEach($exercises, id:\.self, editActions: .all) { $exercise in
                            Text(exercise.name)
                        }
                    }
                    Section {
                        let exercistListView = ExerciseListView(isSelectMode: true) { selectedExercises in
                            exercises.append(contentsOf: selectedExercises)
                        }.navigationTitle("Exercises")
                        NavigationLink(destination: exercistListView) {
                            Text("Add Exercises")
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem {
                Button("Save") {
                    let plan = WorkoutPlan(name: name, exercises: exercises)
                    modelContext.insert(plan)
                    do {
                        try modelContext.save()
                    } catch {
                        print("Failed to save the context: \(error)")
                    }
                    dismiss()
                }.disabled(name.isEmpty || exercises.isEmpty)
            }
        }.navigationTitle("Create Workout Plan")
    }
}

#Preview {
    CreateWorkoutPlanView()
}
