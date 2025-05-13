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
    var id: UUID = UUID()
    var name: String
    var type: WorkoutType
    var defaultExercise: Bool
    
    var primaryMuscles: [String]
    var secondaryMuscles: [String]
    
    var level: String?
    var mechanic: String?
    var force: String?
    
    var instructions: [String]
    
    init(
        name: String,
        type: WorkoutType,
        defaultExercise: Bool = false,
        primaryMuscles: [String] = [],
        secondaryMuscles: [String] = [],
        level: String? = nil,
        mechanic: String? = nil,
        force: String? = nil,
        instructions: [String] = []
    ) {
        self.name = name
        self.type = type
        self.defaultExercise = defaultExercise
        self.primaryMuscles = primaryMuscles
        self.secondaryMuscles = secondaryMuscles
        self.level = level
        self.mechanic = mechanic
        self.force = force
        self.instructions = instructions
    }
}
