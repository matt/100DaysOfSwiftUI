//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Matthew Mohrman on 1/23/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    private let saveKey = "Favorites"
    private var resorts: Set<String>
    
    init() {
        if let resortsArray = UserDefaults.standard.array(forKey: saveKey) as? [String] {
            resorts = Set(resortsArray)
            return
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
}
