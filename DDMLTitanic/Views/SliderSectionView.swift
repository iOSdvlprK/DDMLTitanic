//
//  SliderSectionView.swift
//  DDMLTitanic
//
//  Created by joe on 3/4/25.
//

import SwiftUI

struct SliderSectionView: View {
    @Binding var value: Double
    let sectionTitle: String
    let prompt: String
    let min: Double
    let max: Double
    let step: Double
    
    var body: some View {
        Section(sectionTitle) {
            Text(prompt)
                .fontWeight(.semibold)
            
            Slider(value: $value, in: min...max, step: step)
        }
    }
}

#Preview {
    Form {
        SliderSectionView(
            value: .constant(5),
            sectionTitle: "Parents and children",
            prompt: "Number of parents and children \(5)",
            min: 0,
            max: 20,
            step: 1
        )
    }
}
