//
//  MissionView.swift
//  Moonshot
//
//  Created by Matthew Mohrman on 12/15/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    let mission: Mission
    let astronauts: [CrewMember]
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                GeometryReader { geo in
                    Image(self.mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding(.top)
                        .scaleEffect(self.scaleEffect(outer: geometry, inner: geo), anchor: .bottom)
                        
                }
                .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                
                Text(self.mission.formattedLaunchDate)
                    .font(.headline)
                
                Text(self.mission.description)
                .fixedSize(horizontal: false, vertical: true)
                    .padding()
                
                
                ForEach(self.astronauts, id: \.role) { crewMember in
                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut, missions: self.missions)) {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.primary, lineWidth: 1))
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut], missions: [Mission]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
        
        self.missions = missions
    }
    
    func scaleEffect(outer: GeometryProxy, inner: GeometryProxy) -> CGFloat {
        let initialY = outer.frame(in: .global).minY
        let currentY = inner.frame(in: .global).minY
        let imageHeight = outer.size.width * 0.7
        
        let scale = (imageHeight - (initialY - currentY)) / imageHeight
        
        switch scale {
        case 1...:
            return 1
        case ...0.8:
            return 0.8
        default:
            return scale
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts, missions: missions)
    }
}
