//
//  Plant Reminder.swift
//  plants_app
//
//  Created by NORAH on 30/04/1447 AH.
//

import SwiftUI

// MARK: - Data Models
struct Plant: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var location: String
    var sunExposure: String
    var waterAmount: String
    var isWatered: Bool
    
}

// MARK: - Plant Row View
struct PlantRow: View {
    let customGreen = Color("PrimaryGreen")
    let subTextColor = Color("DescriptiveText")
    let sunTagColor = Color(red: 1.0, green: 0.8, blue: 0.2)
    let waterTagColor = Color(red: 0.4, green: 0.7, blue: 1.0)
    

    @Binding var plant: Plant

    var body: some View {
        HStack {
            Button(action: {
                plant.isWatered.toggle()
            }) {
                ZStack {
                    Circle()
                        .stroke(plant.isWatered ? customGreen : subTextColor.opacity(0.8), lineWidth: 1.5)
                        .frame(width: 20, height: 20)
                    if plant.isWatered {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(customGreen)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())

            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .font(.system(size: 10))
                        .foregroundColor(subTextColor)
                    Text("in \(plant.location)")
                        .font(.caption)
                        .foregroundColor(subTextColor)
                }

                Text(plant.name)
                    .font(.title3)
                    .fontWeight(.regular)

                HStack(spacing: 8) {
                    TagView(iconName: "sun.max", text: plant.sunExposure, color: sunTagColor)
                    TagView(iconName: "drop", text: plant.waterAmount, color: waterTagColor)
                }
            }
            .padding(.vertical, 8)
            .padding(.leading, 8)

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct TagView: View {
    let iconName: String
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.caption2)
                .foregroundColor(color)
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(color)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.1))
        .cornerRadius(6)
    }
}

// MARK: - Main Content View
struct ContentView: View {
    let darkBackground = Color("DarkBackground")
    let customGreen = Color("PrimaryGreen")
    let dividerColor = Color("SeparatorColor")

    @State private var plants: [Plant] = []

    @State private var selectedPlant: Plant? = nil
    @State private var isAddingNewPlant: Bool = false

    var wateredPlantsCount: Int { plants.filter { $0.isWatered }.count }
    var totalPlantsCount: Int { plants.count }
    var wateringProgress: Double { totalPlantsCount > 0 ? Double(wateredPlantsCount) / Double(totalPlantsCount) : 0 }

    var body: some View {
        ZStack {
            darkBackground.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("9:41").font(.system(size: 17, weight: .semibold))
                    Spacer()
                    Image(systemName: "wifi").font(.system(size: 12))
                    Image(systemName: "battery.100").font(.system(size: 12))
                }
                .padding(.horizontal, 20)
                .padding(.top, 1)

                HStack {
                    Text("My Plants").font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                    Text("🌱").font(.largeTitle)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 5)
                Divider().background(dividerColor)

                // Status Banner
                if wateredPlantsCount == 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Your plants are waiting for a sip 💦")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                } else {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(wateredPlantsCount) of your plants feel loved today✨")
                            .font(.headline)
                            .foregroundColor(.white)

                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(dividerColor.opacity(0.5))
                                    .frame(height: 6)
                                Capsule()
                                    .fill(customGreen)
                                    .frame(width: geometry.size.width * CGFloat(wateringProgress), height: 6)
                            }
                        }
                        .frame(height: 6)
                        .padding(.bottom, 10)
                        Divider().background(dividerColor)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }

                // Plant List
                List {
                    ForEach($plants) { $plant in
                        PlantRow(plant: $plant)
                            .listRowBackground(darkBackground)
                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .onTapGesture {
                                self.selectedPlant = plant
                            }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(darkBackground)
                .listStyle(PlainListStyle())
                .sheet(item: $selectedPlant) { plant in
                    EditPlantView() // افتراضي الآن، ممكن تعدلي لاحقًا
                }

                // Add Button
                HStack {
                    Spacer()
                    Button(action: {
                        self.isAddingNewPlant = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(customGreen)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                .sheet(isPresented: $isAddingNewPlant) {
                    SetReminderView { newPlant in
                        plants.append(newPlant) // 👈 هنا يتم إضافة النبتة الجديدة للقائمة
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
