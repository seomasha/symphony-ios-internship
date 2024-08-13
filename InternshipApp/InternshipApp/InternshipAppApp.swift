//
//  InternshipAppApp.swift
//  InternshipApp
//
//  Created by Denis Tojaga on 12. 8. 2024..
//

import SwiftUI

@main
struct InternshipAppApp: App {
    
    let taskManager = TaskManager()
    
    var body: some Scene {
        WindowGroup {
            CreateTaskView()
                .environmentObject(taskManager)
        }
    }
}
