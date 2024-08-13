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
    
    var body: some Scene {
        WindowGroup {
            CreateTaskView()
                .environmentObject(taskManager)
        }
    }
}
