//
//  ContentView.swift
//  plants_app
//
//  Created by NORAH on 28/04/1447 AH.
//

import SwiftUI

struct MyPlantsExactView: View {
    
    // يحدد حالة الشيت (مخفي افتراضياً)
    @State private var showingReminderSheet = false
    
    // الألوان المحددة عبر Assets
    let backgroundColor = Color("DarkBackground") // الرمادي الداكن
    let headerTextColor = Color.white
    let buttonBackgroundColor = Color("PrimaryGreen")
    let buttonBorderColor = Color("ButtonBorder")
    let descriptiveTextColor = Color("DescriptiveText")

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
                Image("plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 40)
                
                // عنوان "Start your plant journey!"
                Text("Start your plant journey!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(headerTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                // الوصف
                Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                    .font(.system(size: 16))
                    .foregroundColor(descriptiveTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 200)
                
                // الزر "Set Plant Reminder"
                Button(action: {
                    self.showingReminderSheet = true
                }) {
                    Text("Set Plant Reminder")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 300, minHeight: 42)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(buttonBackgroundColor)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(buttonBorderColor, lineWidth: 2)
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        )
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        // إعدادات الـ Sheet لمنع تصغير الخلفية
        .sheet(isPresented: $showingReminderSheet) {
            SetReminderView()
                .presentationDetents([.large]) // لتغطية الشاشة تقريباً بالكامل
                .presentationCornerRadius(0)  // لإلغاء زوايا الـ sheet الافتراضية
                .presentationBackground(.clear) // لمنع التعتيم أو التحجيم الخلفي
        }
    }
}
struct MyPlantsExactView_Previews: PreviewProvider {
    static var previews: some View {
        MyPlantsExactView()
    }
}
