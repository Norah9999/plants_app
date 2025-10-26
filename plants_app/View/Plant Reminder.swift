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

// MARK: - Plant Row View (PlantRow)
struct PlantRow: View {
    let customGreen = Color("PrimaryGreen")
    let subTextColor = Color("DescriptiveText")
    let sunTagColor = Color(red: 1.0, green: 0.8, blue: 0.2)
    let waterTagColor = Color(red: 0.4, green: 0.7, blue: 1.0)
    
    @Binding var plant: Plant
    
    var body: some View {
        HStack {
            Button(action: {
                // عند النقر، يتم تبديل حالة الري، مما يؤدي إلى إعادة تقييم allPlantsWatered
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
                    .foregroundColor(.white)
                
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

// ** ملاحظة: تم وضع هيكل MyPlants2 هنا ليعمل الكود بشكل صحيح. **
// يمكنك نقله إلى ملفه الخاص إذا أردت.
struct myPlants2: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.fill") // يمكنك استخدام صورة النبات أو أي أيقونة مناسبة
                .font(.system(size: 100))
                .foregroundColor(Color("PrimaryGreen"))
            
            Text("All Done! ✨")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("All Reminders Completed")
                .font(.title3)
                .foregroundColor(Color("DescriptiveText"))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("DarkBackground").edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Main Content View (ContentView)
struct ContentView: View {
    let darkBackground = Color("DarkBackground")
    let customGreen = Color("PrimaryGreen")
    let dividerColor = Color("SeparatorColor")

    @State private var plants: [Plant] = [
        Plant(name: "Monstera", location: "Kitchen", sunExposure: "Full sun", waterAmount: "20–50 ml", isWatered: false),
        Plant(name: "Pothos", location: "Bedroom", sunExposure: "Full sun", waterAmount: "20–50 ml", isWatered: false),
        Plant(name: "Orchid", location: "Living Room", sunExposure: "Full sun", waterAmount: "250–50 ml", isWatered: false),
        Plant(name: "Spider", location: "Kitchen", sunExposure: "Full sun", waterAmount: "20–50 ml", isWatered: false)
    ]

    @State private var selectedPlant: Plant? = nil
    @State private var isAddingNewPlant: Bool = false

    var wateredPlantsCount: Int { plants.filter { $0.isWatered }.count }
    var totalPlantsCount: Int { plants.count }
    var wateringProgress: Double { totalPlantsCount > 0 ? Double(wateredPlantsCount) / Double(totalPlantsCount) : 0 }

    // ✅ الخاصية المحسوبة للتحقق من اكتمال جميع المهام
    var allPlantsWatered: Bool {
        guard !plants.isEmpty else { return false }
        return plants.allSatisfy { $0.isWatered }
    }

    func deletePlant(plantToDelete: Plant) {
        // حذف من المصفوفة المحلية بدلاً من viewModel
        plants.removeAll { $0.id == plantToDelete.id }
    }
    
    var body: some View {
        // ✅ منطق التبديل الشرطي (إذا كان كل شيء مروي، اذهب لـ MyPlants2)
        if allPlantsWatered {
            MyPlants2()
                .preferredColorScheme(.dark)
        } else {
            // المحتوى الأصلي (قائمة النباتات)
            ZStack {
                darkBackground.edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
            
                   
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
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        deletePlant(plantToDelete: $plant.wrappedValue)
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.red)
                                                .frame(width: 40, height: 40)
                                            Image(systemName: "trash.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .semibold))
                                        }
                                    }
                                }
                                .listRowBackground(darkBackground)
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    self.selectedPlant = $plant.wrappedValue
                                }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background(darkBackground)
                    .listStyle(PlainListStyle())
                    
                    // Edit Sheet (يفترض وجود EditPlantView)
                    .sheet(item: $selectedPlant) { selectedPlant in
                        // تأكد من أن EditPlantView موجود في ملفه الخاص
                        // أو أضف تعريفه هنا إذا كان مفقودًا.
                        EditPlantView(
                            plant: $plants[plants.firstIndex(of: selectedPlant)!],
                            deleteAction: deletePlant
                        )
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
                    // ✅ SetReminderView Sheet (لقد تم إصلاح مكانها)
                    .sheet(isPresented: $isAddingNewPlant) {
                        // تأكد من أن SetReminderView موجود في ملفه الخاص
                        SetReminderView { newPlant in
                            plants.append(newPlant)
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
