//
//  WorkoutLog.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import Foundation
import SwiftData

@Model
class WorkoutLog {
    var exercise: WorkoutExercise
    var name: String
    var note: String = ""
    var date: Date
    var duration: TimeInterval? = nil
    
    // Cardio
    var distance: Double? = nil
    
    // Strength
    var reps: Int? = nil
    var weight: Double? = nil
    
    init(name: String, exercise: WorkoutExercise, date: Date = Date.now) {
        self.name = name
        self.exercise = exercise
        self.date = date
    }
}
