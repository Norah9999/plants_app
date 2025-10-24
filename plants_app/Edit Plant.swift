//
//  Edit Plant.swift
//  plants_app
//
//  Created by NORAH on 01/05/1447 AH.
//

import SwiftUI

// يجب أن يكون نموذج Plant متاحاً، سنفترض أنه تم تعريفه في مكان آخر.
/*
struct Plant: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var location: String
    var sunExposure: String
    var waterAmount: String
    var isWatered: Bool
}
*/

struct EditPlantView: View {
    
    // MARK: - 1. ربط البيانات ووظيفة الحذف
    
    // ✅ استقبال النبتة المحددة عبر Binding لتمكين القراءة والكتابة
    @Binding var plant: Plant
    // ✅ استقبال دالة الحذف من الشاشة الرئيسية (ContentView)
    var deleteAction: (Plant) -> Void
    
    @Environment(\.dismiss) var dismiss
    
    // متغيرات الحالة المحلية التي سيتم تعديلها
    @State private var plantName: String
    @State private var room: String
    @State private var light: String
    @State private var wateringDays: String
    @State private var waterAmount: String
    
    // الألوان
    let darkBackground = Color("DarkBackground")
    let itemColor = Color("ItemRowColor")
    let separatorColor = Color("SeparatorColor")
    let primaryGreen = Color("PrimaryGreen")
    
    // ✅ 2. Initializer لتهيئة متغيرات الـ State بالبيانات الأصلية للنبتة
    init(plant: Binding<Plant>, deleteAction: @escaping (Plant) -> Void) {
        self._plant = plant
        self.deleteAction = deleteAction
        
        // تهيئة الـ @State variables بقيم النبتة الأصلية
        self._plantName = State(initialValue: plant.wrappedValue.name)
        self._room = State(initialValue: plant.wrappedValue.location)
        self._light = State(initialValue: plant.wrappedValue.sunExposure)
        // ملاحظة: بما أن wateringDays غير موجود في نموذج Plant، سنستخدم قيمة افتراضية مؤقتة
        self._wateringDays = State(initialValue: "Once a week")
        self._waterAmount = State(initialValue: plant.wrappedValue.waterAmount)
        
        // 💡 تنبيه: يجب إضافة خاصية 'wateringDays' إلى نموذج 'Plant' إذا كنت تحتاجها فعلاً.
    }

    var body: some View {
        ZStack {
            darkBackground.edgesIgnoringSafeArea(.all)
             
            VStack(spacing: 0) {
                // شريط العنوان
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            // ... (باقي تصميم زر الإلغاء) ...
                            .resizable().scaledToFit().frame(width: 22, height: 22).foregroundColor(.white).padding(6)
                    }

                    Spacer()
                    
                    // ✅ عرض اسم النبتة في العنوان
                    Text("Edit \(plant.name)").font(.headline).foregroundColor(.white)
                    
                    Spacer()
                    
                    // زر الحفظ: يحفظ التغييرات
                    Button(action: {
                        // 3. حفظ التغييرات إلى الـ Binding (المصفوفة الرئيسية)
                        plant.name = plantName
                        plant.location = room
                        plant.sunExposure = light
                        plant.waterAmount = waterAmount
                        // plant.wateringDays = wateringDays // (إذا تمت إضافته لنموذج Plant)
                        
                        dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            // ... (باقي تصميم زر الحفظ) ...
                            .resizable().scaledToFit().frame(width: 40, height: 40).foregroundColor(primaryGreen)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 30)
                 
                // حقل اسم النبتة (سيظهر الاسم الأصلي الآن)
                HStack {
                    Text("Plant Name").foregroundColor(.white).padding(.leading, 2)
                    Spacer()
                    // 💡 استخدام $plantName المربوط ببيانات النبتة الأصلية
                    TextField("", text: $plantName)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                        .contentShape(Rectangle())
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 15)
                .background(itemColor)
                .cornerRadius(40)
                .padding(.horizontal, 15)
                .padding(.bottom, 40)
                
                // MARK: - المجموعات داخل بطاقات دائرية
                ScrollView {
                    VStack(spacing: 20) {
                        // مجموعة الغرفة والضوء (باستخدام ReminderRow)
                        VStack(spacing: 0) {
                            Menu {
                                ForEach(["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"], id: \.self) { roomOption in
                                    Button(action: { room = roomOption }) {
                                        Text(roomOption)
                                        if room == roomOption { Image(systemName: "checkmark") }
                                    }
                                }
                            } label: {
                                ReminderRow(icon: "location", title: "Room", value: $room)
                            }

                            Divider().background(separatorColor)

                            Menu {
                                ForEach(["Full sun", "Partial Sun", "Low Light"], id: \.self) { lightOption in
                                    Button(action: { light = lightOption }) {
                                        Text(lightOption)
                                        if light == lightOption { Image(systemName: "checkmark") }
                                    }
                                }
                            } label: {
                                ReminderRow(icon: "sun.max", title: "Light", value: $light)
                            }
                        }
                        .padding().background(itemColor).cornerRadius(25).padding(.horizontal, 15).padding(.bottom, 20)

                        // مجموعة الري وكمية الماء (باستخدام ReminderRow)
                        VStack(spacing: 0) {
                            Menu {
                                ForEach(["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"], id: \.self) { dayOption in
                                    Button(action: { wateringDays = dayOption }) {
                                        Text(dayOption)
                                        if wateringDays == dayOption { Image(systemName: "checkmark") }
                                    }
                                }
                            } label: {
                                // 💡 استخدام ReminderRow بدلاً من Edit
                                ReminderRow(icon: "drop", title: "Watering Days", value: $wateringDays)
                            }

                            Divider().background(separatorColor)

                            Menu {
                                ForEach(["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"], id: \.self) { amountOption in
                                    Button(action: { waterAmount = amountOption }) {
                                        Text(amountOption)
                                        if waterAmount == amountOption { Image(systemName: "checkmark") }
                                    }
                                }
                            } label: {
                                ReminderRow(icon: "drop", title: "Water", value: $waterAmount)
                            }
                        }
                        .padding().background(itemColor).cornerRadius(25).padding(.horizontal, 15)
                        
                        // زر الحذف: يستخدم دالة deleteAction الممررة
                        Button(action: {
                            // 4. تنفيذ وظيفة الحذف ثم إغلاق الشاشة
                            deleteAction(plant) // حذف النبتة المحددة
                            dismiss()
                        }) {
                            Text("Delete Reminder")
                                .fontWeight(.semibold)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.1)) // تغيير لون الخلفية للتنبيه
                                .cornerRadius(25)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 30)
                        .padding(.bottom, 50)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .clipShape(.rect(topLeadingRadius: 30, topTrailingRadius: 30))
        .background(darkBackground)
        .preferredColorScheme(.dark)
    }
}

// ----------------------------------------------------------------------
// ✅ تغيير اسم هيكل Edit إلى ReminderRow
// ----------------------------------------------------------------------
struct reminderRow: View {
    var icon: String
    var title: String
    @Binding var value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 20)
                
            Text(title).foregroundColor(.white)
            Spacer()
            
            Text(value)
                .foregroundColor(.gray)
                
            Image(systemName: "chevron.up.chevron.down")
                .font(.system(size: 10))
                .foregroundColor(.gray)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 8)
    }
}

// ----------------------------------------------------------------------
// Preview
// ----------------------------------------------------------------------
struct EditPlantView_Previews: PreviewProvider {
    static var previews: some View {
        // يجب تمرير قيمة افتراضية لـ plant و deleteAction
        EditPlantView(
            plant: .constant(Plant(name: "Test Plant", location: "Bedroom", sunExposure: "Partial Sun", waterAmount: "50-100 ml", isWatered: false)),
            deleteAction: { _ in } // دالة حذف فارغة للمعاينة
        )
    }
}
