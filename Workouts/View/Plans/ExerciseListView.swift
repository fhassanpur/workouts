//
//  ExerciseListView.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) var modelContext
    @State private var searchFilter: String = ""
    
    var body: some View {
        ExerciseList(searchQuery: searchFilter)
        .toolbar {
            ToolbarItem {
                Button(action: presentAddExerciseModal) {
                    Label("Add Exercise", systemImage: "plus")
                }
            }
        }.searchable(text: $searchFilter, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("Exercises")
    }
    
    private func presentAddExerciseModal() {
        
    }
}

struct ExerciseList: View {
    @Query private var userExercises: [WorkoutExercise]
    @Query private var defaultExercises: [WorkoutExercise]
    
    init(searchQuery: String) {
        self._userExercises = Query(filter: #Predicate<WorkoutExercise> {
            if searchQuery.isEmpty {
                return !$0.defaultExercise
            } else {
                return !$0.defaultExercise && $0.name.localizedStandardContains(searchQuery)
            }
        }, sort: \.name)
        self._defaultExercises = Query(filter: #Predicate<WorkoutExercise> {
            if searchQuery.isEmpty {
                return $0.defaultExercise
            } else {
                return $0.defaultExercise && $0.name.localizedStandardContains(searchQuery)
            }
        }, sort: \.name)
    }
    
    var body: some View {
        List {
            if !userExercises.isEmpty {
                Section("My Exercises") {
                    ForEach(userExercises) { exercise in
                        Text(exercise.name)
                    }
                }
            }
            if !defaultExercises.isEmpty {
                Section("Default Exercises") {
                    ForEach(defaultExercises) { exercise in
                        Text(exercise.name)
                    }
                }
            }
        }.overlay {
            if userExercises.isEmpty && defaultExercises.isEmpty {
                ContentUnavailableView.search
            }
        }
    }
}

#Preview {
    ExerciseListView()
}
