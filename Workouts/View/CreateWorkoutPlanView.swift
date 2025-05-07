//
//  CreateWorkoutPlanView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI

struct CreateWorkoutPlanView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var exercises: [WorkoutExercise] = []
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Text("Create Workout Plan")
                    .font(.headline)
                Spacer()
                Button("Save") {
                    
                }.disabled(name.isEmpty || exercises.isEmpty)
            }.padding()
            
            TextField("Name", text: $name)
                .limitInputLength(value: $name, length: 50)
                .padding(.horizontal)
            
            NavigationView {
                List {
                    Section {
                        ForEach($exercises, id:\.self, editActions: .all) { $exercise in
                            Text(exercise.name)
                        }
                    }
                    Section {
                        Button("Add Exercise") {
                            
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CreateWorkoutPlanView()
}
