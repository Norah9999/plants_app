//
//  plants_appApp.swift
//  plants_app
//
//  Created by NORAH on 28/04/1447 AH.
//

import SwiftUI

@main
struct plants_appApp: App {
    @StateObject private var viewModel = PlantViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MyPlantsExactView()
            }
            .environmentObject(viewModel) // مهم جداً لتمرير viewModel لكل الشاشات
            .preferredColorScheme(.dark)
        }
    }
}
