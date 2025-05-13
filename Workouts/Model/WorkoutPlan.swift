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
    var setCount: [UUID: Int]
    var ordering: [UUID]
    
    init(name: String, exercises: [WorkoutExercise], setCounts: [UUID: Int], ordering: [UUID] = []) {
        self.name = name
        self.exercises = exercises
        self.setCount = setCounts
        self.ordering = ordering
    }
}
