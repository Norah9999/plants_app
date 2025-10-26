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
    // عرض الشاشة التالية كشيت كامل الشاشة
    @State private var isPresentingContentFullScreen = false
    
    // ربط الـ ViewModel المشترك لضمان التمرير داخل fullScreenCover
    @EnvironmentObject var viewModel: PlantViewModel
    
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
                
                // الزر "Set Plant Reminder" - يفتح الشيت لإضافة تذكير
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
                                        .stroke(buttonBorderColor, lineWidth: 0)
                                )
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                        )
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
        // الشيت: عند الحفظ، يقفل الشيت ثم نعرض ContentView كشيت كامل الشاشة
        .sheet(isPresented: $showingReminderSheet) {
            SetReminderView(onSave: { _ in
                // SetReminderView يستدعي dismiss() بنفسه
                // ننتظر لحظة قصيرة حتى ينتهي إغلاق الشيت ثم نعرض التالي
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation {
                        isPresentingContentFullScreen = true
                    }
                }
            })
            .environmentObject(viewModel) // تمرير الـ viewModel للشيت أيضاً
        }
        // عرض ContentView كشيت كامل الشاشة ليظهر وكأنه استمرار طبيعي
        .fullScreenCover(isPresented: $isPresentingContentFullScreen) {
            ContentView()
                .environmentObject(viewModel) // تمرير الـ viewModel لضمان الربط
                .preferredColorScheme(.dark)
        }
    }
}

struct MyPlantsExactView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyPlantsExactView()
                .environmentObject(PlantViewModel()) // للمعاينة فقط
        }
        .preferredColorScheme(.dark)
    }
}
