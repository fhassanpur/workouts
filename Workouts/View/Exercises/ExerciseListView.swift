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
            ExerciseList(searchQuery: $searchFilter, isSelectMode: isSelectMode, doneAction: doneAction)
            .modelContext(modelContext)
            .toolbar {
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
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) var editMode
    
    @Query(sort: \WorkoutExercise.name) private var allExercises: [WorkoutExercise]
    
    @State private var isSelectMode: Bool
    @State private var selectedExercises: Set<WorkoutExercise> = []
    
    @Binding private var searchQuery: String
    private let doneAction: ((Array<WorkoutExercise>) -> Void)?
    
    init(
        searchQuery: Binding<String>,
        isSelectMode: Bool,
        doneAction: ((Array<WorkoutExercise>) -> Void)? = nil
    ) {
        self._searchQuery = searchQuery
        self.isSelectMode = isSelectMode
        self.doneAction = doneAction
    }
    
    private func fetchExercises(defaultsOnly: Bool) -> [WorkoutExercise] {
        let predicate = #Predicate<WorkoutExercise> { exercise in
            exercise.defaultExercise == defaultsOnly &&
            (searchQuery.isEmpty || exercise.name.localizedStandardContains(searchQuery))
        }

        let descriptor = FetchDescriptor<WorkoutExercise>(predicate: predicate, sortBy: [SortDescriptor(\.name)])
        do {
            return try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    var body: some View {
        let userExercises = fetchExercises(defaultsOnly: false)
        let defaultExercises = fetchExercises(defaultsOnly: true)
        
        List(selection: $selectedExercises) {
            if !userExercises.isEmpty {
                Section("My Exercises") {
                    ForEach(userExercises, id: \.self) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise).navigationTitle(exercise.name)) {
                            Text(exercise.name)
                        }
                    }
                }
            }
            if !defaultExercises.isEmpty {
                Section("Default Exercises") {
                    ForEach(defaultExercises, id: \.self) { exercise in
                        NavigationLink(destination: ExerciseDetailView(exercise: exercise).navigationTitle(exercise.name)) {
                            Text(exercise.name)
                        }
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
