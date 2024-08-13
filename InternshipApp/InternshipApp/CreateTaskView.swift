//
//  CreateTaskView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct CreateTaskView: View {
    
    @State private var taskName: String = ""
    @State private var taskDetails: String = ""
    
    @FocusState private var taskNameIsFocused: Bool
    @FocusState private var taskDetailsIsFocused: Bool
    
    @EnvironmentObject var taskManager: TaskManager
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    TextField("Enter the task name: ", text: $taskName)
                        .focused($taskNameIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                    TextField("Enter the task description: ", text: $taskDetails)
                        .focused($taskDetailsIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        let newTask = Task(taskName: taskName, taskDescription: taskDetails)
                        taskManager.addTask(task: newTask)
                        taskName = ""
                        taskDetails = ""
                    }, label: {
                        Text("Add new task")
                    }).buttonStyle(.borderedProminent)
                }.padding()
                Spacer()
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: TaskListView(taskManager: taskManager)) {
                        Image(systemName: "list.bullet")
                    }
                }
            }
            .navigationTitle("Add task")
        }
    }
}

#Preview {
    CreateTaskView()
        .environmentObject(TaskManager())
}
