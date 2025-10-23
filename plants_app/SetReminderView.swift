import SwiftUI

struct SetReminderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    // متغيرات وهمية لحقول الإدخال
    @State private var plantName: String = "Pothos"
    @State private var room: String = "Bedroom"
    @State private var light: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var waterAmount: String = "20-50 ml"

    // الألوان الدقيقة من التصميم
    // الخلفية الكلية الداكنة جدًا (أسود داكن)
    let darkBackground = Color(red: 25/255, green: 25/255, blue: 25/255) 
    // لون الصفوف في القائمة (رصاصي داكن وواضح)
    let itemColor = Color(red: 50/255, green: 50/255, blue: 50/255) 
    // لون الخط الفاصل الرصاصي الفاتح جدًا
    let separatorColor = Color(red: 70/255, green: 70/255, blue: 70/255) 

    var body: some View {
        // ZStack هو الحاوية الرئيسية
        ZStack {
            // 1. الخلفية الداكنة للشاشة بأكملها
            darkBackground.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // شريط العنوان (Top Bar)
                HStack {
                    // زر الإلغاء (X)
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // زر الحفظ (علامة الصح)
                    Button(action: { dismiss() }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(Color(hex: "5CB895"))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                
                // 2. قائمة حقول الإدخال
                List {
                    // حقول الإدخال (Sections)
                    Section {
                        HStack {
                            Text("Plant Name").foregroundColor(.white)
                            Spacer()
                            TextField("", text: $plantName)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .listRowBackground(itemColor)

                    Section {
                        ReminderRow(icon: "house", title: "Room", value: $room)
                        ReminderRow(icon: "sun.max", title: "Light", value: $light)
                    }
                    .listRowBackground(itemColor)

                    Section {
                        ReminderRow(icon: "drop", title: "Watering Days", value: $wateringDays)
                        ReminderRow(icon: "drop", title: "Water", value: $waterAmount)
                    }
                    .listRowBackground(itemColor)
                    
                }
                
                // 💡 التعديلات النهائية على الـ List
                .listStyle(.insetGrouped)
                // 💡 إخفاء الخلفية البيضاء الافتراضية
                .scrollContentBackground(.hidden) 
                .environment(\.defaultMinListRowHeight, 1) 
                .scrollIndicators(.hidden)
                // 💡 لون الخط الفاصل الرصاصي الفاتح
                .tint(separatorColor) 
                
                // 💡 الفرض القوي: تطبيق الخلفية السوداء على الـ List نفسها
                // هذا يغطي أي جزء أبيض متبقي من القائمة
                .background(darkBackground) 
            }
        }
        // تطبيق الزوايا الدائرية على الشاشة بأكملها (لتظهر كـ Popover)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        // تطبيق الخلفية السوداء على كل ما يحيط بالزوايا الدائرية (لضمان السواد)
        .background(darkBackground)
    }
}

// ... (كود ReminderRow)
struct ReminderRow: View {
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
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}