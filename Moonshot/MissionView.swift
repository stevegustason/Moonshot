//
//  MissionView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/10/23.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]
    
    var body: some View {
        // Use GeometryReader so we can set our width appropriately
        GeometryReader { geometry in
            // Create a scrollable view
            ScrollView {
                // With a VStack
                VStack {
                    // Containing the resized image, with a max width of 60%
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                    // Add in our launch date below the mission badge
                    Text(mission.formattedLaunchDate)
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.5))
                        .padding(.vertical)
                    
                    // A custom 2 unit tall light background rectangular divider with some padding
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding(.horizontal)
                    
                    // A crew header, with a frame to allow us to use leading alignment, and some horizontal padding so it fits with the rest of the text
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    // Add in our horizontal crew scroll view
                    CrewScrollView(mission: mission, astronauts: astronauts)
                    
                    // With another VStack containing our mission description below our mission highlights header
                    VStack(alignment: .leading) {
                        // Add a custom divider - a rectangle that's 2 units high, with our custom light background color, and some vertical padding
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
