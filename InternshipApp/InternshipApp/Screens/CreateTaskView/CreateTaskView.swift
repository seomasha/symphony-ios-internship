//
//  CreateTaskView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct CreateTaskView: View {
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    
    @FocusState private var taskNameIsFocused: Bool
    @FocusState private var taskDescriptionIsFocused: Bool
    
    @StateObject var taskViewModel: TaskViewModel
    @StateObject var profileViewModel: ProfileScreenViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    TextFieldView(placeholder: "Enter the task name:", text: $taskName, isFocused: _taskNameIsFocused)
                    
                    TextFieldView(placeholder: "Enter the task description:", text: $taskDescription, isFocused: _taskDescriptionIsFocused)
                    
                    Button(action: {
                        let newTask = TaskModel(taskName: taskName, taskDescription: taskDescription)
                        taskViewModel.addTask(task: newTask)
                        taskName = ""
                        taskDescription = ""
                    }, label: {
                        //NavigationLink(destination: TaskListView(taskViewModel: taskViewModel, profileViewModel: profileViewModel)) {
                            Label("Add new task", systemImage: "plus.app")
                                .foregroundStyle(.white)
                                .controlSize(.large)
                        //}
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(!validate())
                }
                .padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: TaskListView(taskViewModel: taskViewModel, profileViewModel: profileViewModel)) {
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileScreenView(profileViewModel: profileViewModel, taskViewModel: taskViewModel)) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
            .navigationTitle("Add task")
            .navigationBarBackButtonHidden(true)
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

#Preview {
    CreateTaskView(taskViewModel: TaskViewModel(), profileViewModel: ProfileScreenViewModel())
}
