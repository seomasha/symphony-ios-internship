//
//  TaskListView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 12. 8. 2024..
//

import SwiftUI

struct TaskListView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @ObservedObject var profileViewModel: ProfileScreenViewModel
    
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
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: CreateTaskView(taskViewModel: taskViewModel, profileViewModel: profileViewModel)) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: ProfileScreenView(profileViewModel: profileViewModel, taskViewModel: taskViewModel)) {
                        Image(systemName: "person.crop.circle")
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    TaskListView(taskViewModel: TaskViewModel(), profileViewModel: ProfileScreenViewModel())
}
