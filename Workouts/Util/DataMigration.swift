//
//  DataMigration.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import SwiftData

class DataMigration {
    
    static func migrateJsonData(_ modelContext: ModelContext) {
        print("Performing first time migration...")
        
        let jsonExercises: JsonExerciseList = JsonLoader.load(fromFile: "exercises.json")
        for exercise in jsonExercises.exercises {
            var type = WorkoutType.other
            if exercise.category == "strength" {
                type = .strength
            }
            let newExercise = WorkoutExercise(
                name: exercise.name,
                type: type,
                defaultExercise: true,
                primaryMuscles: exercise.primaryMuscles,
                secondaryMuscles: exercise.secondaryMuscles,
                level: exercise.level,
                mechanic: exercise.mechanic,
                force: exercise.force,
                instructions: exercise.instructions
            )
            modelContext.insert(newExercise)
        }
        do {
            try modelContext.save()
        } catch {
            print("Failed to save the context: \(error)")
        }
        
        print("First time migration completed!")
    }
}
