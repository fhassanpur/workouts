//
//  WorkoutExercise.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import Foundation
import SwiftData

@Model
class WorkoutExercise {
    var name: String
    var type: WorkoutType
    var defaultExercise: Bool
    
    init(name: String, type: WorkoutType, defaultExercise: Bool = false) {
        self.name = name
        self.type = type
        self.defaultExercise = defaultExercise
    }
}
