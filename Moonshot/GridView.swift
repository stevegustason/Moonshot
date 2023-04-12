//
//  GridView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/11/23.
//

import SwiftUI

struct GridView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    // Set our LazyVGrid layout
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
            // Create a scrollable view
        ScrollView {
            // With a LazyVGrid, so it only loads data as needed, with the layout set to our adapative columns layout specified in our variable above
            LazyVGrid(columns: columns) {
                // ForEach of our mission structs
                ForEach(missions) { mission in
                    // Create a navigation link
                    NavigationLink {
                        // Have the link go to the MissionView, passing in the specific mission and the decoded astronauts dictionary
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        // Create a VStack with an image of each mission's logo, the mission's name, and the mission's launch date
                        VStack {
                            // Make our image resize and scale to our 100x100 frame at its original aspect ratio
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
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
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        // Make our NavigationLink into a rounded rectangle with a light border
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        GridView(missions: missions, astronauts: astronauts)
    }
}
