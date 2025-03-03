//
//  SegmentSectionView.swift
//  DDMLTitanic
//
//  Created by joe on 3/3/25.
//

import SwiftUI

struct SegmentSectionView: View {
    @Binding var selected: String
    let options: [String]
    let sectionTitle: String
    let prompt: String
    
    var body: some View {
        Section(sectionTitle) {
            Text(prompt)
                .fontWeight(.semibold)
            
            Picker(prompt, selection: $selected) {
                ForEach(options, id: \.self) { currentSelected in
                    Text(currentSelected)
                        .tag(currentSelected)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    Form {
        SegmentSectionView(
            selected: .constant("Second Class"),
            options: TitanicModel.passengerClasses,
            sectionTitle: "Passenger class",
            prompt: "What passenger class are you?"
        )
        
        SegmentSectionView(
            selected: .constant("Cherbourg"),
            options: TitanicModel.ports,
            sectionTitle: "Port",
            prompt: "What port did you embark from?"
        )
    }
}
