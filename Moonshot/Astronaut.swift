//
//  Astronaut.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/9/23.
//

import Foundation

// Struct to track our astronauts - their ID, name, and a description
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
