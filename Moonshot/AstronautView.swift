//
//  AstronautView.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/10/23.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        // Similar to our MissionView, we'll create a scrollable view
        ScrollView {
            // With a Vstack
            VStack {
                // Containing the image of our astronaut, resizable and scaled to fit, with some padding
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal)
                    .padding(.vertical)

                // And the astronaut description, all pulled from our Astronaut struct
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
