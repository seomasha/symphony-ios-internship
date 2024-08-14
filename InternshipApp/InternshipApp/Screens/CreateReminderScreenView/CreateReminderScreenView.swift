//
//  CreateReminderScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import SwiftUI

struct CreateReminderScreenView: View {
    
    @ObservedObject var reminderViewModel: ReminderViewModel
    @ObservedObject var createReminderViewModel: CreateReminderViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    reminderViewModel.isPresented = false
                } label: {
                    Image(systemName: "xmark")
                }.padding()
            }
            TextFieldView(placeholder: "Enter reminder title: ", text: $createReminderViewModel.reminderTitle)
                .padding()
            TextFieldView(placeholder: "Enter reminder description", text: $createReminderViewModel.reminderDescription)
                .padding()
            
            DatePicker("Enter reminder date: ", selection: $createReminderViewModel.reminderDate)
                .datePickerStyle(.compact)
                .padding()
            
            Toggle("Enable recurrence", isOn: $createReminderViewModel.isOn)
                .padding()
            
            Picker("Recurrence:", selection: $createReminderViewModel.selectedOption) {
                ForEach(createReminderViewModel.options, id: \.self) { option in
                        Text(option)
                }
            }.disabled(!createReminderViewModel.disableRecurrence()).padding()
            
            Button {
                
                if createReminderViewModel.isOn {
                    reminderViewModel.addReminder(reminder: ReminderModel(title: createReminderViewModel.reminderTitle, description: createReminderViewModel.reminderDescription, date: createReminderViewModel.reminderDate, recurrence: createReminderViewModel.selectedOption))
                } else {
                    reminderViewModel.addReminder(reminder: ReminderModel(title: createReminderViewModel.reminderTitle, description: createReminderViewModel.reminderDescription, date: createReminderViewModel.reminderDate, recurrence: "No recurrence"))
                }
                
                createReminderViewModel.reminderTitle = ""
                createReminderViewModel.reminderDescription = ""
                createReminderViewModel.isOn = false
                
                reminderViewModel.isPresented = false
            } label: {
                Label("Add reminder", systemImage: "plus.app")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .disabled(!createReminderViewModel.validate())
        }
        Spacer()
    }
}

#Preview {
    CreateReminderScreenView(reminderViewModel: ReminderViewModel(), createReminderViewModel: CreateReminderViewModel())
}
