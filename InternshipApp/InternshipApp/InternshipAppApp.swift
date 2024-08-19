//
//  InternshipAppApp.swift
//  InternshipApp
//
//  Created by Denis Tojaga on 12. 8. 2024..
//

import SwiftUI

@main
struct InternshipAppApp: App {
    
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            CreateTaskView(
                taskViewModel: TaskViewModel(),
                profileViewModel: ProfileScreenViewModel(),
                reminderViewModel: ReminderViewModel())
        }
    }
}
