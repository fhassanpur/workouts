//
//  JsonExercise.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import Foundation

struct JsonExerciseList: Hashable, Codable {
    var exercises: [JsonExercise]
}

struct JsonExercise: Hashable, Codable {
    var name: String
    var force: String?
    var level: String
    var mechanic: String?
    var equipment: String?
    var primaryMuscles: [String]
    var secondaryMuscles: [String]
    var instructions: [String]
    var category: String
}
