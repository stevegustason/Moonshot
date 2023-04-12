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
    
    // Variable to track whether we are showing a grid or list view
    @State private var showingGrid = true
    
    // Function to toggle our showingGrid variable
    func gridOrListToggle () {
        showingGrid.toggle()
    }
    
    var body: some View {
        NavigationView {
            // If showingGrid is true, then we show our grid view
            Group {
                if showingGrid {
                    GridView(missions: missions, astronauts: astronauts)
                    // Otherwise, we show our list view
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .listStyle(.plain)
            // The navigation title color belongs to the NavigationView and will show up as black or white depending on if the user is in light mode or dark mode. Since we're using a dark background, we want to tell Swift our user prefers dark mode ALWAYS so the header appears white.
            .preferredColorScheme(.dark)
            // Give our view a dark background using our custom color extension
            .background(.darkBackground)
            // Button that toggles our grid/list view, and changes the text depending on the state of showingGrid
            .toolbar {
                Button(showingGrid ? "List" : "Grid", action: gridOrListToggle)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
