//
//  ContentView.swift
//  Moonshot
//
//  Created by Matthew Mohrman on 12/13/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingLaunchDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { (mission: Mission) in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts, missions: self.missions)) {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if self.showingLaunchDates {
                            Text(mission.formattedLaunchDate)
                        } else {
                            VStack(alignment: .leading) {
                                ForEach(mission.crew, id: \.name) { crewRole in
                                    Text(self.astronauts.first(where: {
                                        $0.id == crewRole.name
                                        })?.name ?? "")
                                }
                            }
                        }
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: self.missionListAccessibilityView(mission: mission, showingLaunchDates: self.showingLaunchDates))
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingLaunchDates.toggle()
                }) {
                    Text("Toggle Display")
            })
        }
    }
    
    func missionListAccessibilityView(mission: Mission, showingLaunchDates: Bool) -> Text {
        let text = Text("\(mission.displayName).")
        
        if showingLaunchDates {
            if mission.launchDate != nil {
                return text + Text(" Launch date \(mission.formattedLaunchDate)")
            }
        } else {
            return text + Text("Crew members: \(mission.accessibleCrewNames)")
        }
        
        return text
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
