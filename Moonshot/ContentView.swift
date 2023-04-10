//
//  ContentView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/8/23.
//

import SwiftUI

struct ContentView: View {
    // Decode our astronauts json file containing info about all of our astronauts. We need to specify the type that will be returned here because we used a generic function in our Bundle extension.
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    // Decode our missions json file containing info about all of our missions.
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    // Set our LazyVGrid layout
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
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
            .navigationTitle("Moonshot")
            // The navigation title color belongs to the NavigationView and will show up as black or white depending on if the user is in light mode or dark mode. Since we're using a dark background, we want to tell Swift our user prefers dark mode ALWAYS so the header appears white.
            .preferredColorScheme(.dark)
            // Give our ScrollView a dark background using our custom color extension
            .background(.darkBackground)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
