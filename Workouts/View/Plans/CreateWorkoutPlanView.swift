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
    
    @State private var setCounts: [UUID: Int] = [:]
    @State private var ordering: [UUID] = []
    
    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .limitInputLength(value: $name, length: 50)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                .padding()
            
            NavigationStack {
                List {
                    Section {
                        ForEach($exercises, id:\.self, editActions: .all) { $exercise in
                            WorkoutExerciseRow(exercise: exercise, allSetCounts: $setCounts)
                        }.onMove { fromOffset, toOffset in
                            ordering.move(fromOffsets: fromOffset, toOffset: toOffset)
                            print(ordering.description)
                        }
                    }
                    Section {
                        CreateWorkoutPlanAddExerciseButton(exercises: $exercises, setCounts: $setCounts, ordering: $ordering)
                    }
                }
            }
        }.toolbar {
            ToolbarItem {
                Button("Save") {
                    savePlan()
                    dismiss()
                }.disabled(name.isEmpty || exercises.isEmpty)
            }
        }.navigationTitle("Create Workout Plan")
    }
    
    private func savePlan() {
        let plan = WorkoutPlan(name: name, exercises: exercises, setCounts: setCounts)
        modelContext.insert(plan)
        do {
            try modelContext.save()
        } catch {
            print("Failed to save the context: \(error)")
        }
    }
}

struct CreateWorkoutPlanAddExerciseButton: View {
    @Binding var exercises: [WorkoutExercise]
    @Binding var setCounts: [UUID: Int]
    @Binding var ordering: [UUID]
    
    var body: some View {
        let destination = ExerciseListView(isSelectMode: true) { selectedExercises in
            exercises.append(contentsOf: selectedExercises)
            exercises.forEach { exercise in
                if setCounts[exercise.id] == nil {
                    setCounts[exercise.id] = 1
                }
                if !ordering.contains(exercise.id) {
                    ordering.append(exercise.id)
                }
            }
        }.navigationTitle("Exercises")
        NavigationLink(destination: destination) {
            Text("Add Exercises")
        }
    }
}

struct WorkoutExerciseRow: View {
    @State var exercise: WorkoutExercise
    @State var setCount: Int
    
    @Binding var allSetCounts: [UUID: Int]
    
    init(exercise: WorkoutExercise, allSetCounts: Binding<[UUID : Int]>) {
        self.exercise = exercise
        self._allSetCounts = allSetCounts
        
        self.setCount = allSetCounts.wrappedValue[exercise.id] ?? 1
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
            allSetCounts[exercise.id] = newValue
        }
    }
}

#Preview {
    CreateWorkoutPlanView()
}
