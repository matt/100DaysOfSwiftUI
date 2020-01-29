//
//  Resort.swift
//  SnowSeeker
//
//  Created by Matthew Mohrman on 1/23/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    static let sizes = [
        1: "Small",
        2: "Average",
        3: "Large"
    ]
    static let prices = [
        1: "$",
        2: "$$",
        3: "$$$"
    ]
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
