//
//  Plant.swift
//  plants_app
//
//  Created by NORAH on 04/05/1447 AH.
//

import Foundation

struct Plant: Identifiable, Equatable, Codable {
    let id = UUID()
    var name: String
    var location: String
    var sunExposure: String
    var waterAmount: String
    var isWatered: Bool
}
