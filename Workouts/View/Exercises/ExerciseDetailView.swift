//
//  ExerciseDetailView.swift
//  Workouts
//
//  Created by Ferdows on 5/8/25.
//

import SwiftUI
import SVGView

struct ExerciseDetailView: View {
    @State var exercise: WorkoutExercise
    
    var body: some View {
        ScrollView {
            MuscleDetailView(exercise: exercise).padding(.horizontal)
            ClassificationDetailView(exercise: exercise).padding(.horizontal)
            InstructionsDetailView(instructions: exercise.instructions).padding(.horizontal)
        }
    }
}

struct MuscleDetailView: View {
    @State var exercise: WorkoutExercise
    
    var body: some View {
        MuscleDiagramView(primaryMuscles: exercise.primaryMuscles, secondaryMuscles: exercise.secondaryMuscles)
        Text("Muscles").font(.title3).bold()
        HStack {
            Spacer()
            Grid(alignment: .leading) {
                if !exercise.primaryMuscles.isEmpty {
                    GridRow {
                        HStack {
                            Circle().fill(MuscleDiagramView.primaryMaskColor).frame(width: 10, height: 10)
                            Text("Primary").bold()
                        }
                        VStack(alignment: .leading) {
                            ForEach(exercise.primaryMuscles, id:\.self) { muscle in
                                Text(muscle.capitalized)
                            }
                        }
                    }
                    Divider()
                }
                if !exercise.secondaryMuscles.isEmpty {
                    GridRow {
                        HStack {
                            Circle().fill(MuscleDiagramView.secondaryMaskColor).frame(width: 10, height: 10)
                            Text("Secondary").bold()
                        }
                        VStack(alignment: .leading) {
                            ForEach(exercise.secondaryMuscles, id:\.self) { muscle in
                                Text(muscle.capitalized)
                            }
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct ClassificationDetailView: View {
    @State var exercise: WorkoutExercise
    
    var body: some View {
        VStack {
            Text("Classification").font(.title3).bold().padding()
            HStack {
                Spacer()
                Grid(alignment: .leading) {
                    if let level = exercise.level {
                        GridRow {
                            Text("Level").bold()
                            Text(level.capitalized)
                        }
                        Divider()
                    }
                    if let mechanic = exercise.mechanic {
                        GridRow {
                            Text("Mechanic").bold()
                            Text(mechanic.capitalized)
                        }
                        Divider()
                    }
                    if let force = exercise.force {
                        GridRow {
                            Text("Force").bold()
                            Text(force.capitalized)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct InstructionsDetailView: View {
    @State var instructions: [String]
    
    var body: some View {
        VStack {
            Text("Instructions").font(.title3).bold().padding()
            ForEach(Array(instructions.enumerated()), id:\.offset) { index, instruction in
                Text("\(index + 1).  \(instruction)\n")
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    ExerciseDetailView(exercise: WorkoutExercise(name: "Bench Press", type: .strength, primaryMuscles: ["chest", "shoulders"], secondaryMuscles: ["triceps", "shoulders"], level: "beginner", mechanic: "compound", force: "push", instructions: [
        "Lie back on a flat bench. Using a medium width grip (a grip that creates a 90-degree angle in the middle of the movement between the forearms and the upper arms), lift the bar from the rack and hold it straight over you with your arms locked. This will be your starting position.",
        "From the starting position, breathe in and begin coming down slowly until the bar touches your middle chest.",
        "After a brief pause, push the bar back to the starting position as you breathe out. Focus on pushing the bar using your chest muscles. Lock your arms and squeeze your chest in the contracted position at the top of the motion, hold for a second and then start coming down slowly again. Tip: Ideally, lowering the weight should take about twice as long as raising it.",
        "Repeat the movement for the prescribed amount of repetitions.",
        "When you are done, place the bar back in the rack."
      ]))
}
