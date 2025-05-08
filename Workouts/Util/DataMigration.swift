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
            let newExercise = WorkoutExercise(name: exercise.name, type: type, defaultExercise: true)
            modelContext.insert(newExercise)
        }
        
        print("First time migration completed!")
    }
}
