//
//  NotificationManager.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 16. 8. 2024..
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
}
