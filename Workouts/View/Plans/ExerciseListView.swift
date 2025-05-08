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
    @State private var isSelectMode: Bool
    
    private let doneAction: ((Array<WorkoutExercise>) -> Void)?
    
    init(isSelectMode: Bool = false, doneAction: ((Array<WorkoutExercise>) -> Void)? = nil) {
        self.isSelectMode = isSelectMode
        self.doneAction = doneAction
    }
    
    var body: some View {
        NavigationStack {
            let exerciseList = ExerciseList(searchQuery: searchFilter, isSelectMode: isSelectMode, doneAction: doneAction)
            
            exerciseList.toolbar {
                if !isSelectMode {
                    ToolbarItem {
                        Button(action: presentAddExerciseModal) {
                            Label("Add Exercise", systemImage: "plus")
                        }
                    }
                }
            }
            .searchable(text: $searchFilter, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle(isSelectMode ? "" : "Exercises")
        }
    }
    
    private func presentAddExerciseModal() {
        
    }
}

struct ExerciseList: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    
    @Query private var userExercises: [WorkoutExercise]
    @Query private var defaultExercises: [WorkoutExercise]
    
    @State private var isSelectMode: Bool
    @State private var selectedExercises: Set<WorkoutExercise> = []
    
    private let doneAction: ((Array<WorkoutExercise>) -> Void)?
    
    init(searchQuery: String,
         isSelectMode: Bool,
         doneAction: ((Array<WorkoutExercise>) -> Void)? = nil
    ) {
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
        self.isSelectMode = isSelectMode
        self.doneAction = doneAction
    }
    
    var body: some View {
        List(selection: $selectedExercises) {
            if !userExercises.isEmpty {
                Section("My Exercises") {
                    ForEach(userExercises, id:\.self) { exercise in
                        Text(exercise.name).tag(exercise.id)
                    }
                }
            }
            if !defaultExercises.isEmpty {
                Section("Default Exercises") {
                    ForEach(defaultExercises, id:\.self) { exercise in
                        Text(exercise.name).tag(exercise.id)
                    }
                }
            }
        }.toolbar {
            if isSelectMode {
                ToolbarItem {
                    Button(action: {
                        doneAction?(Array(selectedExercises))
                        dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
        }.listStyle(.grouped).overlay {
            if userExercises.isEmpty && defaultExercises.isEmpty {
                ContentUnavailableView.search
            }
        }.onAppear {
            if isSelectMode {
                editMode?.wrappedValue = .active
            }
        }
    }
}
