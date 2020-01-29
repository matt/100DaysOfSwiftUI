//
//  Activity.swift
//  HabitTracking
//
//  Created by Matthew Mohrman on 12/18/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var completionCount: Int
}
