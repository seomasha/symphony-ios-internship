//
//  TaskViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

final class TaskViewModel: ObservableObject {
    @Published var taskName: String = ""
    @Published var taskDescription: String = ""
    @Published var tasks: [TaskModel] = []
    
    func addTask(task: TaskModel) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    
    func validate() -> Bool {
        var isValid = true
        
        if taskName.isEmpty || taskDescription.isEmpty{
            isValid = false
        }
        
        return isValid
    }
}
