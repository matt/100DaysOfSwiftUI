//
//  Prospect.swift
//  HotProspects
//
//  Created by Matthew Mohrman on 1/9/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    let introductionDate = Date()
}

class Prospects: ObservableObject {
    static let saveKey = "SavedData"
    
    @Published private(set) var people: [Prospect]
    
    init() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = path.appendingPathComponent(Self.saveKey)
        if let data = try? Data(contentsOf: url) {
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let url = path.appendingPathComponent(Self.saveKey)
            try? encoded.write(to: url)
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
}
