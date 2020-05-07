//
//  ContentView.swift
//  WeSplit
//
//  Created by Feng Chang on 2/27/20.
//  Copyright © 2020 Feng Chang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount: Double {
        guard let orderAmount = Double(checkAmount) else { return 0 }
        let tipSelection = Double(tipPercentages[tipPercentage]) / 100
        let total = orderAmount * (1 + tipSelection)
        
        return total
    }
    
    var totalPerPerson: Double {
        guard let peopleCount = Double(numberOfPeople) else { return 0 }
        let tipSelection = Double(tipPercentages[tipPercentage])
        guard let orderAmount = Double(checkAmount) else { return 0 }
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.numberPad)
                    TextField("Number of people", text: $numberOfPeople)
                    .keyboardType(.numberPad)
                    // Below are the code before self challenge
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total amount for the check")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
