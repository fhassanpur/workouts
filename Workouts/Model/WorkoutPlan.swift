//
//  WorkoutPlan.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import Foundation
import SwiftData

@Model
class WorkoutPlan {
    var name: String
    var exercises: [WorkoutExercise]
    
    init(name: String, exercises: [WorkoutExercise]) {
        self.name = name
        self.exercises = exercises
    }
}
