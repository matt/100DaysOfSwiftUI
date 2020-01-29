//
//  ContentView.swift
//  WeConvert
//
//  Created by Matthew Mohrman on 11/22/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var originalValue = ""
    @State private var originalUnit = 0
    @State private var convertedUnit = 0
    
    let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    var convertedValue: Double? {
        guard let value = Double(originalValue) else {
            return nil
        }
        
        let original = Measurement(value: value, unit: temperatureUnits[originalUnit])
        let converted = original.converted(to: temperatureUnits[convertedUnit])
        
        return converted.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Convert")) {
                    HStack {
                        TextField("Original value", text: $originalValue)
                            .keyboardType(.decimalPad)
                        
                        Spacer()
                        
                        Picker("Original unit", selection: $originalUnit) {
                            ForEach(0 ..< temperatureUnits.count) {
                                Text("\(self.temperatureUnits[$0].symbol)")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Section(header: Text("To")) {
                    Picker("Converted Unit", selection: $convertedUnit) {
                        ForEach(0 ..< temperatureUnits.count) {
                            Text("\(self.temperatureUnits[$0].symbol)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Result")) {
                    Text(String(format: convertedValue == nil ? "" : "%.2f", convertedValue ?? 0))
                }
            }
            .navigationBarTitle("WeConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
