//
//  RollDiceView.swift
//  RollDice
//
//  Created by Matthew Mohrman on 1/22/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import CoreHaptics
import SwiftUI

struct RollDiceView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var diceCount = 0
    @State private var diceSideCount = 0
    @State private var showingSettings = false
    @State private var diceValues = [String]()
    @State private var diceValuesTotal: Int?
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                ZStack {
                    HStack(spacing: 15) {
                        ForEach(self.diceValues, id: \.self) { diceValue in
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                Text(diceValue)
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    if diceValuesTotal != nil {
                        Text("Total: \(diceValuesTotal!)")
                            .offset(x: 0, y: -50)
                    }
                }
                
                Button("Roll") {
                    self.rollDice()
                    self.complexDiceRoll()
                }
            }
            .navigationBarTitle(Text("Roll Dice"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingSettings = true
                }) {
                    Image(systemName: "gear")
                }
                .accessibility(label: Text("Settings"))
            )
        }
        .sheet(isPresented: $showingSettings, onDismiss: setupData) {
            SettingsView()
        }
        .onAppear {
            self.prepareHaptics()
            self.setupData()
        }
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func setupData() {
        let originalSettingsData = (diceCount, diceSideCount)
        loadSettingsData()
        let currentSettingsData = (diceCount, diceSideCount)
        if originalSettingsData != currentSettingsData {
            resetDiceValues()
            reseteDiceValuesTotal()
        }
    }
    
    func loadSettingsData() {
        let diceCount = UserDefaults.standard.integer(forKey: SettingsKey.diceCount.rawValue)
        self.diceCount = diceCount != 0 ? diceCount : 3
        
        let diceSideCount = UserDefaults.standard.integer(forKey: SettingsKey.diceSideCount.rawValue)
        self.diceSideCount = diceSideCount != 0 ? diceSideCount : 6
    }
    
    func resetDiceValues() {
        diceValues = Array(repeating: "?", count: diceCount)
    }
    
    func rollDice() {
        reseteDiceValuesTotal()
        
        for delay in [0, 0.1, 0.2, 0.6, 1.2] {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.diceValues = (1 ... self.diceCount).map { _ in String(Int.random(in: 1 ... self.diceSideCount)) }
                
                if delay == 1.2 {
                    self.calculateDiceValuesTotal()
                    self.storeRoll()
                }
            }
        }
    }
    
    func calculateDiceValuesTotal() {
        diceValuesTotal = diceValues.compactMap { Int($0) }.reduce(0, +)
    }
    
    func reseteDiceValuesTotal() {
        diceValuesTotal = nil
    }
    
    func storeRoll() {
        let dice: [Dice] = diceValues.map {
            let dice = Dice(context: self.moc)
            dice.value = Int16($0)!

            return dice
        }

        let roll = Roll(context: moc)
        roll.created = Date()
        roll.addToDice(NSOrderedSet(array: dice))

        do {
            try moc.save()
        } catch {
            print("Unable to save dice roll: \(error.localizedDescription)")
        }
    }
    
    func complexDiceRoll() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in 0 ..< 10 {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0.5 + 0.1 * Double(i))
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
