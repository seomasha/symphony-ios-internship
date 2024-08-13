//
//  TaskViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
}
