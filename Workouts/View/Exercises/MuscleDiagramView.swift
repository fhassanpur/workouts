//
//  MuscleDiagramView.swift
//  Workouts
//
//  Created by Ferdows on 5/10/25.
//

import SwiftUI
import SVGView

struct MuscleDiagramView: View {
    @State var primaryMuscles: [String]
    @State var secondaryMuscles: [String]
    
    static let primaryMaskColor = Color.red
    static let secondaryMaskColor = Color.blue
    
    private static let muscleGroupMapping: [String: (String, Int)] = [
        "chest": ("chest", 4),
        "triceps": ("triceps", 6),
        "quadriceps": ("quads", 10),
        "abdominals": ("abs", 10),
        "biceps": ("biceps", 4),
        "calves": ("calves", 10),
        "forearms": ("forearms", 11),
        "shoulders": ("deltoids", 6),
        "abductors": ("abductors", 4),
        "adductors": ("adductors", 2),
        "hamstrings": ("hamstrings", 6),
        "lats": ("lats", 2),
        "traps": ("traps", 4),
        "lower back": ("lats", 2),
        "middle back": ("rhomboids", 2),
        "glutes": ("glutes", 2),
    ]
    
    var body: some View {
        let svg = SVGView(contentsOf: Bundle.main.url(forResource: "figure", withExtension: "svg")!)
        
        ZStack {
            // Mask primary after secondary in case of overlap
            svg
            maskedMuscleGroup(svg, muscles: secondaryMuscles, mask: MuscleDiagramView.secondaryMaskColor)
            maskedMuscleGroup(svg, muscles: primaryMuscles, mask: MuscleDiagramView.primaryMaskColor)
            
        }.frame(width: 333, height: 304)
    }
    
    func maskedMuscleGroup(_ svg: SVGView, muscles: [String], mask: Color) -> some View {
        ForEach(muscles, id:\.self) { muscle in
            let muscleIds = MuscleDiagramView.muscleGroupMapping[muscle] ?? ("", 0)
            ForEach(0..<muscleIds.1, id:\.self) { i in
                mask.mask {
                    svg.getNode(byId: "\(muscleIds.0)_\(i)")?.toSwiftUI()
                }
            }
        }
    }
}

#Preview {
    MuscleDiagramView(primaryMuscles: ["chest"], secondaryMuscles: ["triceps"])
}
