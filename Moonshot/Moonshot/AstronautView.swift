//
//  AstronautView.swift
//  Moonshot
//
//  Created by Matthew Mohrman on 12/15/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                Image(self.astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                
                Text(self.astronaut.description)
                    .padding()
                    .layoutPriority(1)
                
                VStack(alignment: .leading) {
                    Text("Missions:")
                    .bold()
                    ForEach(self.missions) {
                        Text("\u{2022} \($0.displayName)")
                    }
                }
            .padding()
                .frame(width: geometry.size.width, alignment: .leading)
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        self.missions = missions.filter({ mission -> Bool in
            mission.crew.contains(where: { crewRole -> Bool in
                crewRole.name == astronaut.id
            })
        })
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[10], missions: missions)
    }
}
