//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/9/23.
//

import Foundation

// We're using an extension to load all of our JSON data so we can do it in one place and take it out of our ContentView
extension Bundle {
    // We have a decode function that takes a string filename and returns a dictionary of Astronauts. If we add in angle brackets, that allows us to make our method generic by providing a placeholder for certain types. We need to make sure our placeholder is codable so we can decode it though, so we add a constraint as well.
    func decode<T: Codable>(_ file: String) -> T {
        // First, set our file url that was passed to the function. If that doesn't work, throw a fatal error to crash the app.
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        // Then, try to load our file into an instance of data. If that doesn't work, throw a fatal error to crash the app.
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        // Create an instance of our decoder.
        let decoder = JSONDecoder()
        
        // Swift's JSONDecoder has a property called dateDecodingStrategy which determines how it should decode dates. We create an instance of our DateFormatter here.
        let formatter = DateFormatter()
        // Then we set our format to “a year, then a dash, then a zero-padded month, then a dash, then a zero-padded day”. Warning: MM means zero-padded month, but mm means zero-padded minute
        formatter.dateFormat = "y-MM-dd"
        // Then we set our decoder's dateDecodingStrategy to a formatted version of our formatter
        decoder.dateDecodingStrategy = .formatted(formatter)

        // Then pass our data through the JSONDecoder. If that doesn't work, throw a fatal error to crash the app.
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        // If that all worked, return our loaded data (dictionary of Astronauts).
        return loaded
    }
}
