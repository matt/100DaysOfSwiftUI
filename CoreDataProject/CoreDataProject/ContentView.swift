//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Matthew Mohrman on 12/28/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import CoreData
import SwiftUI

enum PredicateCondition: String {
    case beginsWith = "BEGINSWITH"
    case beginsWithCaseInsensitive = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsCaseInsensitive = "CONTAINS[c]"
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(sortDescriptors: [NSSortDescriptor(key: "lastName", ascending: true)], filterKey: "lastName", filterCondition: .containsCaseInsensitive, filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
