//
//  CardView.swift
//  Flashzilla
//
//  Created by Matthew Mohrman on 1/13/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct CardBackground: ViewModifier {
    let differentiateWithoutColor: Bool
    let offset: CGSize
    var fillColor: Color {
        switch offset.width {
        case ..<0:
            return .red
        case 0:
            return .white
        default:
            return .green
        }
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                differentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(fillColor)
            )
    }
}

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var offset = CGSize.zero
    @State private var isShowingAnswer = false
    @State private var feedback = UINotificationFeedbackGenerator()
    
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .shadow(radius: 10)
                .modifier(CardBackground(differentiateWithoutColor: differentiateWithoutColor, offset: offset))
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                    .font(.largeTitle)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
            }
            .onEnded { _ in
                if abs(self.offset.width) > 100 {
                    if self.offset.width > 0 {
                        self.feedback.notificationOccurred(.success)
                        self.removal?(true)
                    } else {
                        self.feedback.notificationOccurred(.error)
                        self.removal?(false)
                        
                        self.offset = .zero
                        self.isShowingAnswer = false
                    }
                } else {
                    withAnimation(Animation.spring().speed(0.1)) {
                        self.offset = .zero
                    }
                }
            }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
