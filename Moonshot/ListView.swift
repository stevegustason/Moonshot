//
//  ListView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/11/23.
//

import SwiftUI

struct ListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            // ForEach of our mission structs
            ForEach(missions) { mission in
                // Create a navigation link
                NavigationLink {
                    // Have the link go to the MissionView, passing in the specific mission and the decoded astronauts dictionary
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    // Create an HStack with an image of each mission's logo, the mission's name, and the mission's launch date
                    HStack {
                        // Make our image resize and scale to our 100x100 frame at its original aspect ratio
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        VStack {
                            // Display the mission's displayName (programatically set in our struct)
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            // Use nil coalescing to unwrap our mission launch date optional
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .listStyle(.plain)
            .listRowBackground(Color.darkBackground)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListView(missions: missions, astronauts: astronauts)
    }
}
