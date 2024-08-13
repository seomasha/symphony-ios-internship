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
    
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    TextFieldView(placeholder: "Enter the task name:", text: $taskName, isFocused: _taskNameIsFocused)
                    
                    TextFieldView(placeholder: "Enter the task description:", text: $taskDetails, isFocused: _taskDetailsIsFocused)
                    
                    Button(action: {
                        let newTask = Task(taskName: taskName, taskDescription: taskDetails)
                        taskViewModel.addTask(task: newTask)
                        taskName = ""
                        taskDetails = ""
                    }, label: {
                        Text("Add new task")
                    }).buttonStyle(.borderedProminent)
                }.padding()
                
                Spacer()
                
            }.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: TaskListView(taskViewModel: taskViewModel)) {
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
        .environmentObject(TaskViewModel())
}
