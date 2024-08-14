//
//  CreateTaskView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct CreateTaskView: View {
        
    @ObservedObject var taskViewModel: TaskViewModel
    @ObservedObject var profileViewModel: ProfileScreenViewModel
    @ObservedObject var reminderViewModel: ReminderViewModel
    @ObservedObject var createReminderViewModel: CreateReminderViewModel
    
    @FocusState private var taskNameIsFocused: Bool
    @FocusState private var taskDescriptionIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 20) {
                    TextFieldView(placeholder: "Enter the task name:", text: $taskViewModel.taskName, isFocused: _taskNameIsFocused)
                    
                    TextFieldView(placeholder: "Enter the task description:", text: $taskViewModel.taskDescription, isFocused: _taskDescriptionIsFocused)
                    
                    Button(action: {
                        let newTask = TaskModel(taskName: taskViewModel.taskName, taskDescription: taskViewModel.taskDescription)
                        taskViewModel.addTask(task: newTask)
                        taskViewModel.taskName = ""
                        taskViewModel.taskDescription = ""
                    }, label: {
                        Label("Add new task", systemImage: "plus.app")
                            .foregroundStyle(.white)
                            .controlSize(.large)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(!taskViewModel.validate())
                }
                .padding()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: TaskListView(taskViewModel: taskViewModel, profileViewModel: profileViewModel, reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)) {
                        Image(systemName: "list.bullet")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileScreenView(profileViewModel: profileViewModel, taskViewModel: taskViewModel, reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)) {
                        Image(systemName: "person.crop.circle")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ReminderScreenView(taskViewModel: taskViewModel, profileViewModel: profileViewModel, reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)) {
                        Image(systemName: "bell")
                    }
                }
            }
            .navigationTitle("Add task")
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    CreateTaskView(taskViewModel: TaskViewModel(), profileViewModel: ProfileScreenViewModel(), reminderViewModel: ReminderViewModel(), createReminderViewModel: CreateReminderViewModel())
}
