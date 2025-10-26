//
//  Plant.swift
//  plants_app
//
//  Created by NORAH on 04/05/1447 AH.
//

// PlantModel.swift

import Foundation
import SwiftUI

// يجب أن يكون Plant قابل للـ Identifiable لكي يستخدم في List
struct plant: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var location: String
    var sunExposure: String
    var waterAmount: String
    var isWatered: Bool // حالة هل تم ريّها
}

// نموذج ViewModel لادارة البيانات (يجب أن يكون لديك بالفعل هذا أو ما يشابهه)
class plantViewModel: ObservableObject {
    @Published var plants: [Plant] = [
        // بيانات تجريبية ليظهر شيء في شاشة Reminders
        Plant(name: "Monstera", location: "Kitchen", sunExposure: "Full sun", waterAmount: "20-50 ml", isWatered: false)
    ]
    
    // دالة لحفظ التذكير الجديد
    func saveReminder(plant: Plant) {
        plants.append(plant)
    }
}
