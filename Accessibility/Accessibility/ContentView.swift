//
//  ContentView.swift
//  Accessibility
//
//  Created by Matthew Mohrman on 1/7/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "jeff-siepman-5C4caOKoIFM",
        "yulia-khlebnikova-t_XM5pTc6wc"
    ]
    let labels = [
        "Wine Glass",
        "Pancakes"
    ]
    
    @State private var rating = 3
    
    var body: some View {
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1 ... 5)
        .accessibility(value: Text("\(rating) out of 5"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
