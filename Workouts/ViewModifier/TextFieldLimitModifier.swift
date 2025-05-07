//
//  TextFieldLimitModifier.swift
//  Workouts
//
//  Created by Ferdows on 5/4/25.
//

import SwiftUI

struct TextFieldLimitModifier: ViewModifier {
    @Binding var value: String
    var length: Int
    
    func body(content: Content) -> some View {
        content.onChange(of: $value.wrappedValue) { _, newValue in
            value = String(newValue.prefix(length))
        }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifier(value: value, length: length))
    }
}
