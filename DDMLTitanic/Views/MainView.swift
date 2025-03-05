//
//  MainView.swift
//  DDMLTitanic
//
//  Created by joe on 2/28/25.
//

import SwiftUI
import CoreML

struct MainView: View {
    @State private var tm: TitanicModel = .init(
        passengerClass: "Second Class",
        sex: "Male",
        age: 18,
        siblingsSpouses: 2,
        parentsChildren: 4,
        fare: 5,
        port: "Cherbourg"
    )
    
    @State private var survival: Bool? = nil
    @State private var showAlert = false
    @State private var survivalRate: Double = -1
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    // passenger class
                    SegmentSectionView(
                        selected: $tm.passengerClass,
                        options: TitanicModel.passengerClasses,
                        sectionTitle: "Passenger class",
                        prompt: "What passenger class are you?"
                    )
                    
                    // gender/sex
                    SegmentSectionView(
                        selected: $tm.sex,
                        options: TitanicModel.genders,
                        sectionTitle: "Gender",
                        prompt: "What is your gender?"
                    )
                    
                    // age
                    SliderSectionView(
                        value: $tm.age,
                        sectionTitle: "Age",
                        prompt: "Age: \(tm.age.formatted())",
                        min: 0,
                        max: 120,
                        step: 0.5
                    )
                    
                    // siblings and spouses
                    SliderSectionView(
                        value: $tm.siblingsSpouses,
                        sectionTitle: "Siblings and Spouses",
                        prompt: "Number of siblings/spouses: \(tm.siblingsSpouses.formatted())",
                        min: 0,
                        max: 10,
                        step: 1
                    )
                    
                    // parents and children
                    SliderSectionView(
                        value: $tm.parentsChildren,
                        sectionTitle: "Parents and Children",
                        prompt: "Number of parents and children: \(tm.parentsChildren.formatted())",
                        min: 0,
                        max: 10,
                        step: 1
                    )
                    
                    // ticket price? (in 1910 pounds)
                    SliderSectionView(
                        value: $tm.fare,
                        sectionTitle: "Ticket price? (in 1910 pounds)",
                        prompt: "Ticket price £\(tm.fare.formatted())",
                        min: 0,
                        max: 600,
                        step: 0.1
                    )
                    
                    // port
                    SegmentSectionView(
                        selected: $tm.port,
                        options: TitanicModel.ports,
                        sectionTitle: "Port",
                        prompt: "What port did you embark from?"
                    )
                }
                .scrollIndicators(.hidden)
                .blur(radius: showAlert ? 5 : 0)
                .disabled(showAlert)
                
                if showAlert {
                    Button(action: {
                        withAnimation {
                            showAlert.toggle()
                        }
                    }, label: {
                        if let survival {
                            VStack {
                                Text(survival ? "SURVIVED!" : "DID NOT SURVIVED")
                                
                                Text("Probability of Survival: \(survivalRate)")
                            }
                            .padding()
                            .background(.black)
                            .foregroundStyle(.white)
                        }
                    })
                }
            }
            .navigationTitle("Surviving the Titanic")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: compute, label: {
                        Text("Compute")
                            .bold()
                            .foregroundStyle(.red)
                            .opacity(showAlert ? 0 : 1)
                    })
                }
            }
        }
    }
    
    func compute() {
        do {
            let config = MLModelConfiguration()
            let model = try TitanicRegressionModel_1(configuration: config)
            let prediction = try model
                .prediction(
                    Pclass: tm.Pclass,
                    Sex: tm.sex,
                    Age: tm.age,
                    SibSp: Int64(tm.siblingsSpouses),
                    Parch: Int64(tm.parentsChildren),
                    Fare: tm.fare,
                    Embarked: String(tm.port.first ?? "C")
                )
            
            // result between 0 and 1 = probability of survival
            survivalRate = prediction.Survived
            survival = prediction.Survived > 0.5
        } catch {
            survival = nil
        }
        
        showAlert = true
    }
}

#Preview {
    MainView()
}
