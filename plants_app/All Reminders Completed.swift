//
//  MyPlant2.swift
//  plants_app
//
//  Created by NORAH on 01/05/1447 AH.
//

import SwiftUI

struct MyPlants2: View {
    
    // يحدد حالة الشيت (مخفي افتراضياً)
    @State private var showingReminderSheet = false
    
    // الألوان المحددة عبر Assets
    let backgroundColor = Color("DarkBackground") // الرمادي الداكن
    let headerTextColor = Color.white
    let buttonBackgroundColor = Color("PrimaryGreen")

    let buttonBorderColor = Color("ButtonBorder")
    let descriptiveTextColor = Color("DescriptiveText")
    let primaryGreen = Color("PrimaryGreen")
    

    var body: some View {
        ZStack {
            // 1. الخلفية الرمادية الداكنة بالكامل
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                // شريط الحالة (الوقت وأيقونات الشبكة/البطارية)
                HStack {
                    Text("9:41")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(headerTextColor)
                    Spacer()
                    Image(systemName: "wifi")
                        .foregroundColor(headerTextColor)
                        .font(.system(size: 12))
                    Image(systemName: "battery.100")
                        .foregroundColor(headerTextColor)
                        .font(.system(size: 12))
                }
                .padding(.horizontal, 20)
                .padding(.top, 1)
                
              
                
                // العنوان "My Plants 🌱"
                HStack {
                    Text("My Plants ")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(headerTextColor)
                    Text("🌱")
                        .font(.system(size: 35))
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 30)
                
                // الخط النحيف
                Divider()
                    .background(headerTextColor.opacity(0.5))
                    .frame(height: 1)
                    .padding(.vertical, 8)

                
                Spacer()
                
                // صورة النبتة
                Image("plant2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 40)
                
                // عنوان "Start your plant journey!"
                Text("All Done! 🎉")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(headerTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                // الوصف
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .foregroundColor(descriptiveTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 200)
                
                // Add Button
                HStack {
                    Spacer()
                    Button(action: {
                      
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(primaryGreen)
                            .clipShape(Circle())
                           
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
                .padding(.bottom, 5)
                
               
            }
        }
        

    }
}
struct MyPlants2_Previews: PreviewProvider {
    static var previews: some View {
        MyPlants2()
    }
}
