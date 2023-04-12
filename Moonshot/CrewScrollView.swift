//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/11/23.
//

import SwiftUI

struct CrewScrollView: View {
    let mission: Mission
    
    // A struct to store our crew members we'll be gathering from our other JSON file
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    // And our crew which will contain the array of crew members that worked on this mission
    let crew: [CrewMember]
    
    // Custom initializer for this struct to get our crew members, it takes a mission and a dictionary of astronauts
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        // To get our crew, we'll loop over the mission crew, then for each crew member
        self.crew = mission.crew.map { member in
            // Look in the dictionary to find the one with the matching ID
            if let astronaut = astronauts[member.name] {
                // Then convert that into a CrewMember object
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                // If we can't find an astronaut using their ID, we've got major problems and should crash
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        // Add our horizontal scrollview outside of our VStack below (so it doesn't get cut off by the leading edge), with horizontal scrollbars not showing
        ScrollView(.horizontal, showsIndicators: false) {
            // With an HStack
            HStack {
                // ForEach of our crew members
                ForEach(crew, id: \.role) { crewMember in
                    // Create a navigation link
                    NavigationLink {
                        // Have that go to our AstronautView, passing in the specific crewMember.astronaut Astronaut struct
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        // Create an HStack
                        HStack {
                            // With the astronaut's picture on the left with a capsule shape
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )

                            // And a VStack on the right, with the astronaut's name and role
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundColor(.white)
                                    .font(.title3.bold())
                                Text(crewMember.role)
                                    .foregroundColor(crewMember.role == "Commander" ? .white : .secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct CrewScrollView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        CrewScrollView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
