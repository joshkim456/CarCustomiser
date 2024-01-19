//
//  Car.swift
//  CarCustomiser
//
//  Created by Kim, Joshua (WING) on 19/01/2024.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    func displayStats() -> String {
        return "Make: \(make)\nModel: \(model)\nTop Speed: \(topSpeed)mph\nAcceleration (0-60): \(acceleration)s\nHandling: \(handling)"
    }
}


