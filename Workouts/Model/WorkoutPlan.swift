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
    var setCount: [Int: Int]
    
    init(name: String, exercises: [WorkoutExercise], setCounts: [Int: Int]) {
        self.name = name
        self.exercises = exercises
        self.setCount = setCounts
    }
}
