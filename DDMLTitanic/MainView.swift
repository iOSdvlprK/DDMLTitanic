//
//  MainView.swift
//  DDMLTitanic
//
//  Created by joe on 2/28/25.
//

import SwiftUI

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
                    Section("Passenger Class") { Text("TODO: Siblings and spouses") }
                    
                    // gender/sex
                    Section("Gender/sex") { Text("TODO: Siblings and spouses") }
                    
                    // age
                    Section("Age") { Text("TODO: Age") }
                    
                    // siblings and spouses
                    Section("Siblings and spouses") { Text("TODO: Siblings and spouses") }
                    
                    // parents and children
                    Section("Parents and children") { Text("TODO: Parents and children") }
                    
                    // ticket price? (in 1910 pounds)
                    Section("Ticket price?") { Text("TODO: Ticket price?") }
                    
                    // port
                    Section("Port") { Text("TODO: Port") }
                }
                
                if showAlert {
                    Text("TODO: SHOW RESULT ABOUT SURVIVAL")
                }
            }
            .navigationTitle("Surviving the Titanic")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        // TODO: implement - determine survival using model
                    }, label: {
                        Text("Compute")
                            .bold()
                            .foregroundStyle(.red)
                            .opacity(showAlert ? 0 : 1)
                    })
                }
            }
        }
    }
}

#Preview {
    MainView()
}
