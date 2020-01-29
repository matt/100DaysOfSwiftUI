//
//  Card.swift
//  Flashzilla
//
//  Created by Matthew Mohrman on 1/13/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
