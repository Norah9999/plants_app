//
//  Untitled.swift
//  plants_app
//
//  Created by NORAH on 05/05/1447 AH.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    private init() {}
    
    // طلب الإذن من المستخدم
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Error: \(error.localizedDescription)")
            } else {
                print(granted ? "✅ Notifications allowed" : "🚫 Permission denied")
            }
        }
    }
    
    // جدولة إشعار التذكير
    func scheduleWaterReminder(for date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Planto 🌱"
        content.body = "Hey! Let’s water your plant 💧"
        content.sound = .default
        
        // إعداد الوقت للتكرار اليومي
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("✅ Water reminder scheduled at \(date)")
            }
        }
    }
}
