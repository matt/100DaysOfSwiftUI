//
//  ContentView.swift
//  Flashzilla
//
//  Created by Matthew Mohrman on 1/12/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import CoreHaptics
import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

enum SheetType {
    case editCards, settings
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var sheet = (isShowing: false, type: SheetType.editCards)
    @State private var retryIncorrectResponses = false
    @State private var showingTimeoutAlert = false
    @State private var engine: CHHapticEngine?
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.75))
                )
                
                ZStack {
                    ForEach(0 ..< self.cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) { correct in
                            withAnimation {
                                if correct == false && self.retryIncorrectResponses {
                                    self.shuffleIncorrectCard(at: index)
                                } else {
                                    self.removeCard(at: index)
                                }
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button(action: resetCards) { Text("Start Again") }
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            VStack {
                HStack {
                    Button(action: {
                        self.sheet = (isShowing: true, type: .settings)
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.sheet = (isShowing: true, type: .editCards)
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            if self.retryIncorrectResponses {
                                self.shuffleIncorrectCard(at: self.cards.count - 1)
                            } else {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()
                        Button(action: {
                            self.removeCard(at: self.cards.count - 1)
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard self.isActive else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.showingTimeoutAlert = true
                self.complexGameOver()
                self.isActive = false
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        .sheet(isPresented: $sheet.isShowing, onDismiss: {
            if self.sheet.type == .editCards {
                self.resetCards()
            } else {
                self.loadSettings()
            }
        }) {
            if self.sheet.type == .editCards {
                EditCards()
            } else {
                SettingsView()
            }
        }
        .alert(isPresented: $showingTimeoutAlert) {
            Alert(title: Text("Game Over"), message: Text("Would you like to play again?"), primaryButton: .default(Text("Yes"), action: {
                self.resetCards()
            }), secondaryButton: .default(Text("No")))
        }
        .onAppear(perform: setupGame)
    }
    
    func shuffleIncorrectCard(at index: Int) {
        cards.move(fromOffsets: IndexSet(integer: index), toOffset: 0)
    }
    
    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func setupGame() {
        loadSettings()
        resetCards()
        prepareHaptics()
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadCards()
    }
    
    func loadCards() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
                print(cards)
            }
        }
    }
    
    func loadSettings() {
        retryIncorrectResponses = UserDefaults.standard.bool(forKey: "RetryIncorrectResponses")
        print("retryIncorrectResponses: \(retryIncorrectResponses)")
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
    
    func complexGameOver() {
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

        for i in stride(from: 0, to: 0.5, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1.5 + i)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
