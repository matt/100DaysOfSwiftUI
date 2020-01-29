//
//  Mission.swift
//  Moonshot
//
//  Created by Matthew Mohrman on 12/13/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        var name: String
        var role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var imageName: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var accessibleCrewNames: String {
        var crewNames = ""
        
        for i in 0 ..< crew.count {
            if i == crew.count - 1 {
                crewNames += "and \(crew[i].name)"
            } else {
                crewNames += "\(crew[i].name), "
            }
        }
        
        return crewNames
    }
}
