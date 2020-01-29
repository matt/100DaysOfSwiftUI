//
//  Book+Utils.swift
//  Bookworm
//
//  Created by Matthew Mohrman on 12/27/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import Foundation

extension Book {
    var displayGenre: String {
        guard let genre = genre, genre.isEmpty == false else {
            return "fantasy"
        }
        
        return genre
    }
    
    var displayDate: String {
        guard let date = date else {
            return "Unknown date"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: date)
    }
}
