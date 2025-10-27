//
//  MyPlant2.swift
//  plants_app
//
//  Created by NORAH on 01/05/1447 AH.
//

import SwiftUI

struct MyPlants2: View {
    
    @State private var showingReminderSheet = false
    @State private var isPresentingContentFullScreen = false
    
    @EnvironmentObject var viewModel: PlantViewModel
    
    let headerTextColor = Color.white
    let buttonBackgroundColor = Color("PrimaryGreen")
    let buttonBorderColor = Color("ButtonBorder")
    let descriptiveTextColor = Color("DescriptiveText")
    let primaryGreen = Color("PrimaryGreen")
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            VStack(spacing: 0) {
//                HStack {
//                    Text("My Plants ")
//                        .font(.system(size: 35, weight: .bold))
//                        .foregroundColor(headerTextColor)
//                    Text("🌱")
//                        .font(.system(size: 35))
//                    Spacer()
//                }
//                .padding(.leading, 20)
//                .padding(.top, 30)
//                
//                Divider()
//                    .background(headerTextColor.opacity(0.5))
//                    .frame(height: 1)
//                    .padding(.vertical, 8)

                Spacer()
                
                Image("plant2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 40)
                
                Text("All Done! 🎉")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(headerTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .foregroundColor(descriptiveTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 200)
                
                HStack {
                    Spacer()
                    Button(action: {
                        showingReminderSheet = true
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
        .sheet(isPresented: $showingReminderSheet) {
            SetReminderView { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation {
                        isPresentingContentFullScreen = true
                    }
                }
            }
            .environmentObject(viewModel)
        }
//        .fullScreenCover(isPresented: $isPresentingContentFullScreen) {
//            ContentView()
//                .environmentObject(viewModel)
//        }
    }
}

struct MyPlants2_Previews: PreviewProvider {
    static var previews: some View {
        MyPlants2()
            .environmentObject(PlantViewModel())
            .preferredColorScheme(.dark)
    }
}
