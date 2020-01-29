//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Matthew Mohrman on 12/11/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct Question {
    let multiplier: Int
    let multiplicant: Int
    let product: Int
}

struct GameView: View {
    var question: Question
    var onSubmit: (String) -> ()
    @State private var answer = ""
    @State private var rotationDegrees = 0.0

    var body: some View {
        VStack {
            Text("What is \(question.multiplicant) x \(question.multiplier)?")
            TextField("", text: $answer) {
                // noop
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
            
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                withAnimation {
                    let offset: Double = Int(self.answer) == self.question.product ? 360 : -360
                    self.rotationDegrees += offset
                }
                self.onSubmit(self.answer)
                self.answer = ""
            }) {
                Text("Submit")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .rotation3DEffect(Angle(degrees: rotationDegrees), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
        }
    }
}

struct ContentView: View {
    @State private var isConfiguringGame = true
    @State private var multiplicationTable = 9
    @State private var questionCount = 5
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    @State private var correctAnswers = 0
    @State private var isShowingLearningOverview = false
    
    private var questionCountOptions: [Int] {
        let allQuestionsCount = multiplicationTable * multiplicationTable
        var questionCountOptions = [5, 10, 20, allQuestionsCount]
        var index = 2
        while index >= 0, questionCountOptions[index] >= allQuestionsCount {
            questionCountOptions.remove(at: index)
            index -= 1
        }
        
        return questionCountOptions
    }
    
    var body: some View {
        NavigationView {
            Group {
                if isConfiguringGame {
                    VStack {
                        Stepper("Up to \(self.multiplicationTable)", value: $multiplicationTable, in: 1 ... 12) { _ in
                            if !self.questionCountOptions.contains(self.questionCount) {
                                self.questionCount = self.questionCountOptions.last ?? 0
                            }
                        }
                        
                        HStack {
                            Text("Number of questions")
                            
                            Spacer()
                            
                            Picker(selection: $questionCount, label: Text("Number of questions")) {
                                ForEach(questionCountOptions, id: \.self) {
                                    Text(self.questionCountOptions.firstIndex(of: $0) == self.questionCountOptions.count - 1 ? "All" : "\($0)")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .fixedSize()
                        }
                        
                        Button(action: {
                            self.startGame()
                        }) {
                            Text("Start")
                        }
                        
                        Spacer()
                    }
                } else {
                    GameView(question: questions[currentQuestion], onSubmit: answerQuestionAndContinue)
                    .alert(isPresented: $isShowingLearningOverview) { () -> Alert in
                        Alert(title: Text("Learning Complete"), message: Text("You answered \(correctAnswers) question\(correctAnswers == 1 ? "" : "s") correctly."), dismissButton: .default(Text("Play Again")) {
                            self.configureNewGame()
                            })
                    }
                }
            }
            .padding()
            .navigationBarTitle("Multiplication Tables")
        }
    }
    
    func startGame() {
        generateQuestions()
        isConfiguringGame = false
    }
    
    func generateQuestions() {
        var questions = [Question]()
        for i in 1 ... multiplicationTable {
            for j in 1 ... multiplicationTable {
                let question = Question(multiplier: i, multiplicant: j, product: i * j)
                questions.append(question)
            }
        }
        questions.shuffle()
        questions.removeLast(questions.count - questionCount)
        
        self.questions = questions
    }
    
    func answerQuestionAndContinue(_ answer: String) {
        if Int(answer) == questions[currentQuestion].product {
            correctAnswers += 1
        }
        
        if currentQuestion == questionCount - 1 {
            isShowingLearningOverview = true
        } else {
            currentQuestion += 1
        }
    }
    
    func configureNewGame() {
        isConfiguringGame = true
        multiplicationTable = 9
        questionCount = 5
        questions = [Question]()
        currentQuestion = 0
        correctAnswers = 0
        isShowingLearningOverview = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
