//
//  ProgressTabView.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import SwiftUI

struct ProgressTabView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            List {
                let logListView = WorkoutLogListView().modelContext(modelContext)
                    .navigationTitle("History")
                NavigationLink(destination: logListView) {
                    Text("Workout History")
                }
            }.navigationTitle("Progress")
        }
    }
}

#Preview {
    ProgressTabView()
}
