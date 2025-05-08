//
//  WorkoutLogListView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI
import SwiftData

struct WorkoutLogListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var workoutLogs: [WorkoutLog]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    var body: some View {
        List {
            let groupedWorkoutLogs: [Date: [WorkoutLog]] = Dictionary(grouping: workoutLogs) {
                Calendar.current.startOfDay(for: $0.date)
            }
            let groups: [Date] = Array(groupedWorkoutLogs.keys).sorted(by: >)
            ForEach(groups, id: \.self) { group in
                let dateStr = dateFormatter.string(from: group)
                Section(dateStr) {
                    let logs = groupedWorkoutLogs[group]?.sorted {
                        $0.date < $1.date
                    } ?? []
                    ForEach(logs) { log in
                        NavigationLink {
                            Text("\(log.name): \(log.date.description)")
                        } label: {
                            Text("\(log.name): \(log.date.description)")
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem {
                Button(action: addLog) {
                    Label("Add Workout", systemImage: "plus")
                }
            }
        }
    }
    
    private func addLog() {
        withAnimation {
            let workoutLog = WorkoutLog(name: "Log", exercise: WorkoutExercise(name: "Default", type: .other), date: Date.now)
            modelContext.insert(workoutLog)
        }
    }
}
