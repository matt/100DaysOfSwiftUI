//
//  SettingsView.swift
//  RollDice
//
//  Created by Matthew Mohrman on 1/22/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

enum SettingsKey: String {
    case diceCount, diceSideCount
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var diceCount = 3
    @State private var diceSideCount = 6
    
    let diceCountOptions = 1 ... 5
    let diceSideCountOptions = [4, 6, 8, 10, 12, 20, 100]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper("Number of dice: \(self.diceCount)", value: self.$diceCount, in: self.diceCountOptions)
                    
                    VStack(alignment: .leading) {
                        Text("Number of sides:")
                        Picker("Number of sides:", selection: self.$diceSideCount) {
                            ForEach(self.diceSideCountOptions, id: \.self) { option in
                                Text(String(option))
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(leading:
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                , trailing:
                Button("Save") {
                    self.saveSettingsData()
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
        .onAppear(perform: loadSettingsData)
    }
    
    func loadSettingsData() {
        let diceCount = UserDefaults.standard.integer(forKey: SettingsKey.diceCount.rawValue)
        if diceCount != 0 {
            self.diceCount = diceCount
        }
        
        let diceSideCount = UserDefaults.standard.integer(forKey: SettingsKey.diceSideCount.rawValue)
        if diceSideCount != 0 {
            self.diceSideCount = diceSideCount
        }
    }
    
    func saveSettingsData() {
        UserDefaults.standard.set(diceCount, forKey: SettingsKey.diceCount.rawValue)
        UserDefaults.standard.set(diceSideCount, forKey: SettingsKey.diceSideCount.rawValue)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
