//
//  WorkoutPlanListView.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI

struct WorkoutPlanListView: View {
    @State private var showAddPlanModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                EmptyView()
            }.toolbar {
                ToolbarItem {
                    Button(action: presentAddPlanModal) {
                        Label("Add Workout Plan", systemImage: "plus")
                    }
                }
            }.sheet(isPresented: $showAddPlanModal) {
                CreateWorkoutPlanView()
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    private func presentAddPlanModal() {
        showAddPlanModal = true
    }
}

#Preview {
    WorkoutPlanListView()
}
