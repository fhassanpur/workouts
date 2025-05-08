//
//  HomeTabView.swift
//  Workouts
//
//  Created by Ferdows on 5/7/25.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome home!").font(.title).bold()
                Text("Select something to get started.")
            }
        }
    }
}

#Preview {
    HomeTabView()
}
