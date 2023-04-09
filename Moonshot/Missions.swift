//
//  Missions.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/9/23.
//

import Foundation

// Each mission has an ID, may have a launch date (apollo 1 never launched and so doesn't have a launch date, hence why we use an optional here), a crew (which is an array of CrewRole), and a description
struct Mission: Codable, Identifiable {
    // Crew role tracks each crew member's name and role. Adding it as a nested struct since it specifically relates to our mission struct can give our code more context and make it more organized.
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    // We need to specify that our launchDate is a date, rather than a string since we have used our dateDecodingStrategy to format our date correctly
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    // This computed property uses the Mission's id to set a display name for the mission
    var displayName: String {
        "Apollo \(id)"
    }

    // This computed property uses the Misson's id to set the string for the image we'll be loading corresponding to that mission
    var image: String {
        "apollo\(id)"
    }
    
    // This computed property uses the Mission's launchDate to nil coalesce and set a formatted abbreviated date (with time omitted), which will take into account the user's regional date formatting
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
