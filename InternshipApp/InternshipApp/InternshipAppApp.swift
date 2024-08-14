//
//  InternshipAppApp.swift
//  InternshipApp
//
//  Created by Denis Tojaga on 12. 8. 2024..
//

import SwiftUI

@main
struct InternshipAppApp: App {
    
    let taskManager = TaskViewModel()
    @StateObject var profileViewModel = ProfileScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            CreateTaskView(taskViewModel: TaskViewModel(), profileViewModel: profileViewModel, reminderViewModel: ReminderViewModel(), createReminderViewModel: CreateReminderViewModel())
        }
    }
}
