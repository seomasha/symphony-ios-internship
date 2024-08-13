//
//  TaskListView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct TaskListView: View {
    
    let taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(taskViewModel.tasks, id: \.id) { task in
                        TaskView(taskName: task.taskName, taskDescription: task.taskDescription)
                    }
                }
            }
            .navigationTitle("Task list")
            Spacer()
        }
    }
}

#Preview {
    TaskListView(taskViewModel: TaskViewModel())
}
