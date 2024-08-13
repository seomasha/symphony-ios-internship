//
//  TaskListView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct TaskListView: View {
    
    let taskManager: TaskManager
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(taskManager.tasks, id: \.id) { task in
                        TaskView(taskName: task.taskName, taskDescription: task.taskDescription)
                    }
                }
            }
            .navigationTitle("Task list")
            Spacer()
        }
    }
}

struct TaskView: View {
    
    let taskName: String
    let taskDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            Text(taskDescription)
                .font(.subheadline)
        }
    }
}

struct Task: Identifiable, Equatable {
    let id = UUID()
    let taskName: String
    let taskDescription: String
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.taskName == rhs.taskName
    }
}

class TaskManager: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
}

#Preview {
    TaskListView(taskManager: TaskManager())
}
