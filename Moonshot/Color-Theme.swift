//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Steven Gustason on 4/9/23.
//

import Foundation
import SwiftUI

// Create an extension for ShapeStyle, but only for where it's being used as a Color
extension ShapeStyle where Self == Color {
    // Set a dark background color
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }

    // Set a light background color
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}
