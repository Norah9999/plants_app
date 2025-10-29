//
//  Plant.swift
//  plants_app
//
//  Created by NORAH on 04/05/1447 AH.
//

// PlantModel.swift

import SwiftUI

class PlantViewModel: ObservableObject {
    @Published var plants: [Plant] = []

    func addPlant(_ plant: Plant) {
        plants.append(plant)
    }

    func deletePlant(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }
}
