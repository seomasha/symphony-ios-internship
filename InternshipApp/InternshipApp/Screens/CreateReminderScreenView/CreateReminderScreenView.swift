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
            
            if createReminderViewModel.selectedOption == "Custom" {
                HStack {
                    TextFieldView(placeholder: "Days:", text: Binding(
                        get: { String(createReminderViewModel.days) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                createReminderViewModel.days = intValue
                            } else {
                                createReminderViewModel.days = 0
                            }
                        }
                    )).keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Weeks:", text: Binding(
                        get: { String(createReminderViewModel.weeks) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                createReminderViewModel.weeks = intValue
                            } else {
                                createReminderViewModel.weeks = 0
                            }
                        }
                    )).keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Months:", text: Binding(
                        get: { String(createReminderViewModel.months) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                createReminderViewModel.months = intValue
                            } else {
                                createReminderViewModel.months = 0
                            }
                        }
                    )).keyboardType(.numberPad)
                }.padding()
            }

            
            Button {
                if createReminderViewModel.isOn {
                    if createReminderViewModel.selectedOption == "Custom" {
                        var formattedString = ""

                        if createReminderViewModel.days > 0 {
                            formattedString += "\(createReminderViewModel.days) day" + (createReminderViewModel.days > 1 ? "s" : "")
                        }

                        if createReminderViewModel.weeks > 0 {
                            if !formattedString.isEmpty { formattedString += ", " }
                            formattedString += "\(createReminderViewModel.weeks) week" + (createReminderViewModel.weeks > 1 ? "s" : "")
                        }

                        if createReminderViewModel.months > 0 {
                            if !formattedString.isEmpty { formattedString += ", " }
                            formattedString += "\(createReminderViewModel.months) month" + (createReminderViewModel.months > 1 ? "s" : "")
                        }

                        createReminderViewModel.selectedOption = formattedString
                    }
                    
                    reminderViewModel.addReminder(reminder: ReminderModel(title: createReminderViewModel.reminderTitle, description: createReminderViewModel.reminderDescription, date: createReminderViewModel.reminderDate, recurrence: createReminderViewModel.selectedOption))
                    
                } else {
                    reminderViewModel.addReminder(reminder: ReminderModel(title: createReminderViewModel.reminderTitle, description: createReminderViewModel.reminderDescription, date: createReminderViewModel.reminderDate, recurrence: "No recurrence"))
                }
                
                createReminderViewModel.reminderTitle = ""
                createReminderViewModel.reminderDescription = ""
                createReminderViewModel.selectedOption = "Daily"
                createReminderViewModel.isOn = false
                
                createReminderViewModel.days = 0
                createReminderViewModel.weeks = 0
                createReminderViewModel.months = 0
                
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
