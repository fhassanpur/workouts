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
    
    init(name: String, type: WorkoutType) {
        self.name = name
        self.type = type
    }
}
