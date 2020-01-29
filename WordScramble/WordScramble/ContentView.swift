//
//  ContentView.swift
//  WordScramble
//
//  Created by Matthew Mohrman on 12/2/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: self.$newWord, onCommit: self.addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                GeometryReader { geometry in
                    List(self.usedWords, id: \.self) { word in
                        GeometryReader { geo in
                            HStack {
                                Image(systemName: "\(word.count).circle")
                                    .foregroundColor(self.color(outer: geometry, inner: geo))
                                Text(word)
                                Spacer()
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(word), \(word.count) letters"))
                            .offset(x: self.xOffset(outer: geometry, inner: geo), y: 0)
                        }
                    }
                }
                Text("Score: \(self.score)")
            }
            .navigationBarTitle(self.rootWord)
            .onAppear(perform: self.startGame)
            .alert(isPresented: self.$showingError) {
                Alert(title: Text(self.errorTitle), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(leading:
                Button(action: self.startGame) {
                    Text("New Game")
                }
            )
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }
    
    func startGame() {
        if let startGameUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startGameUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                usedWords = []
                rootWord = allWords.randomElement() ?? "silkworm"
                score = 0
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        guard word.count > 2 else {
            return false
        }
        
        guard word != rootWord else {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func xOffset(outer: GeometryProxy, inner: GeometryProxy) -> CGFloat {
        let currentY = inner.frame(in: .global).minY
        let fullHeight = outer.frame(in: .global).size.height
        
        let offset = currentY / fullHeight * 1000 - 1000
        
        return offset > 0 ? offset : 0
    }
    
    func color(outer: GeometryProxy, inner: GeometryProxy) -> Color {
        let currentY = inner.frame(in: .global).minY
        let fullHeight = outer.frame(in: .global).size.height
        
        let red = Double(currentY / fullHeight)
        let green = Double((currentY / fullHeight) / 2)
        let blue = Double(1 - (currentY / fullHeight))
        
        return Color(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
