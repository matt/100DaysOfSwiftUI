//
//  ContentView.swift
//  HabitTracking
//
//  Created by Matthew Mohrman on 12/18/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

class Habits: ObservableObject {
    let activitiesKey = "Activities"
    
    @Published var activities: [Activity] {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(self.activities) {
                UserDefaults.standard.set(encoded, forKey: activitiesKey)
            }
        }
    }
    
    init() {
        let decoder = JSONDecoder()
        
        if let activities = UserDefaults.standard.data(forKey: activitiesKey),
            let decoded = try? decoder.decode([Activity].self, from: activities) {
            self.activities = decoded
        } else {
            self.activities = []
        }
    }
}

struct ContentView: View {
    @ObservedObject var habits = Habits()
    
    @State private var showingNewActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0 ..< self.habits.activities.count) { index in
                    NavigationLink(destination: ActivityDetails(activityIndex: index, habits: self.habits)) {
                        VStack(alignment: .leading) {
                            Text(self.habits.activities[index].title)
                                .font(.headline)
                            Text(self.habits.activities[index].description)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: removeActivities)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton() ,trailing:
                Button(action: {
                    self.showingNewActivity = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingNewActivity) {
                    NewActivity(habits: self.habits)
            }
        }
    }
    
    func removeActivities(atOffsets offsets: IndexSet) {
        habits.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
