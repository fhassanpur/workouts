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
    
    @State private var setCounts: [Int: Int] = [:]
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .limitInputLength(value: $name, length: 50)
                .padding(.horizontal)
            
            NavigationStack {
                List {
                    Section {
                        ForEach($exercises, id:\.self, editActions: .all) { $exercise in
                            WorkoutExerciseRow(exercise: exercise, allSetCounts: $setCounts)
                        }
                    }
                    Section {
                        let exercistListView = ExerciseListView(isSelectMode: true) { selectedExercises in
                            exercises.append(contentsOf: selectedExercises)
                            exercises.forEach { exercise in
                                if setCounts[exercise.id.hashValue] == nil {
                                    setCounts[exercise.id.hashValue] = 1
                                }
                            }
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
                    let plan = WorkoutPlan(name: name, exercises: exercises, setCounts: setCounts)
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

struct WorkoutExerciseRow: View {
    @State var exercise: WorkoutExercise
    @State var setCount: Int
    
    @Binding var allSetCounts: [Int: Int]
    
    init(exercise: WorkoutExercise, allSetCounts: Binding<[Int : Int]>) {
        self.exercise = exercise
        self._allSetCounts = allSetCounts
        
        self.setCount = allSetCounts.wrappedValue[exercise.id.hashValue] ?? 1
    }
    
    var body: some View {
        HStack {
            Text("\(exercise.name)")
            Stepper("\(setCount) Sets") {
                setCount += 1
                if setCount > 99 {
                    setCount = 99
                }
            } onDecrement: {
                setCount -= 1
                if setCount < 1 {
                    setCount = 1
                }
            }
        }.onChange(of: setCount) { _, newValue in
            allSetCounts[exercise.id.hashValue] = newValue
        }
    }
}

#Preview {
    CreateWorkoutPlanView()
}
