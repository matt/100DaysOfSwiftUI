//
//  ActivityDetails.swift
//  HabitTracking
//
//  Created by Matthew Mohrman on 12/18/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ActivityDetails: View {
    var activityIndex: Int
    @ObservedObject var habits: Habits
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(self.habits.activities[activityIndex].title)
                        .font(.headline)
                    Text(self.habits.activities[activityIndex].description)
                        .font(.subheadline)
                }
                
                Spacer()
                
                Image(systemName: "\(self.habits.activities[activityIndex].completionCount).square.fill")
            }
            
            Button(action: {
                self.habits.activities[self.activityIndex].completionCount += 1
            }) {
                Text("Add Completion")
            }
            
            Spacer()
        }
        .padding()
    }
}

struct ActivityDetails_Previews: PreviewProvider {
    static var previews: some View {
        let habits = Habits()
        let activity = Activity(title: "Title", description: "Description", completionCount: 1)
        habits.activities.append(activity)
        
        return ActivityDetails(activityIndex: 0, habits: habits)
    }
}
