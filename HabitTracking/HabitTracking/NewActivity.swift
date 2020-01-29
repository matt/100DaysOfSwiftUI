//
//  NewActivity.swift
//  HabitTracking
//
//  Created by Matthew Mohrman on 12/18/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct NewActivity: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: self.$title)
                TextField("Description", text: self.$description)
            }
            .navigationBarTitle("New Activity")
            .navigationBarItems(trailing:
                Button(action: {
                    let activity = Activity(title: self.title, description: self.description, completionCount: 1)
                    
                    self.habits.activities.append(activity)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            )
        }
    }
}

struct NewActivity_Previews: PreviewProvider {
    static var previews: some View {
        NewActivity(habits: Habits())
    }
}
