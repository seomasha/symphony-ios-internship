//
//  ReminderScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import SwiftUI

struct ReminderScreenView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel
    @ObservedObject var profileViewModel: ProfileScreenViewModel
    @ObservedObject var reminderViewModel: ReminderViewModel
    @ObservedObject var createReminderViewModel: CreateReminderViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(reminderViewModel.reminders, id: \.id) { reminder in
                    ReminderView(reminderTitle: reminder.title, reminderDescription: reminder.description, reminderDate: reminder.date, reminderRecurrence: reminder.recurrence)
                }
            }.padding()
            Spacer()
        }
        .navigationTitle("Reminders")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: TaskListView(taskViewModel: taskViewModel, profileViewModel: profileViewModel, reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)) {
                    Image(systemName: "list.bullet")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: CreateTaskView(taskViewModel: taskViewModel, profileViewModel: profileViewModel, reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .status) {
                Button {
                    reminderViewModel.isPresented = true
                } label: {
                    Label("Create reminder", systemImage: "plus.circle")
                        .foregroundStyle(.white)
                        .controlSize(.extraLarge)
                }
                .sheet(isPresented: $reminderViewModel.isPresented) {
                    CreateReminderScreenView(reminderViewModel: reminderViewModel, createReminderViewModel: createReminderViewModel)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ReminderScreenView(taskViewModel: TaskViewModel(), profileViewModel: ProfileScreenViewModel(), reminderViewModel: ReminderViewModel(), createReminderViewModel: CreateReminderViewModel())
}
