//
//  ContentView.swift
//  Drawing
//
//  Created by Matthew Mohrman on 12/15/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    var lineThickness: CGFloat
    
    var animatableData: CGFloat {
        get { lineThickness }
        set { self.lineThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.midX + lineThickness / 2, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.midX + lineThickness / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - lineThickness / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - lineThickness / 2, y: rect.height / 4))
        path.addLine(to: CGPoint(x: 0, y: rect.height / 4))
        path.addLine(to: CGPoint(x: rect.midX, y: 0))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var location: CGFloat = 0.5

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(stops: [Gradient.Stop(color: self.color(for: value, brightness: 1), location: 0),
                                                                            Gradient.Stop(color: self.color(for: value, brightness: 0.75), location: self.location),
                                                                            Gradient.Stop(color: self.color(for: value, brightness: 0.5), location: 1)]), startPoint: .top, endPoint: .bottom), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineThickness: CGFloat = 50
    @State private var colorCycle = 0.0
    @State private var location: CGFloat = 0.5
    
    var body: some View {
        VStack {
            Arrow(lineThickness: lineThickness)
                .frame(width: 200, height: 200)
                .onTapGesture {
                    withAnimation {
                        self.lineThickness = CGFloat.random(in: 10 ... 100)
                    }
            }
            
            ColorCyclingRectangle(amount: self.colorCycle, location: location)
                .frame(width: 300, height: 300)
                .drawingGroup()

            Text("Color Cycle")
            Slider(value: $colorCycle)
            Text("Location")
            Slider(value: $location)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
