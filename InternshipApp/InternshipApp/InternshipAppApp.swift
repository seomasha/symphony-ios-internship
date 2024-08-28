//
//  InternshipAppApp.swift
//  InternshipApp
//
//  Created by Denis Tojaga on 12. 8. 2024..
//

import SwiftUI
import Firebase

@main
struct InternshipAppApp: App {
    
    /* Code for the TodoApp
    init() {
        NotificationManager.shared.requestAuthorization()
    }
     */
    
    @ObservedObject var userViewModel: UserViewModel
    
    init() {
        FirebaseApp.configure()
        print("Configured Firebase!")
        
        self.userViewModel = UserViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            /* Code for the TodoApp
            CreateTaskView(
                taskViewModel: TaskViewModel(),
                profileViewModel: ProfileScreenViewModel(),
                reminderViewModel: ReminderViewModel())
             */
            
            LoginScreenView(userViewModel: userViewModel)
        }
    }
}
