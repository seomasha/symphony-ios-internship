
import SwiftUI

struct CreateReminderScreenView: View {
    
    @ObservedObject var reminderViewModel: ReminderViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    reminderViewModel.isPresented = false
                } label: {
                    Image(systemName: "xmark")
                }
                .padding()
            }
            
            TextFieldView(placeholder: "Enter reminder title: ", text: $reminderViewModel.reminderTitle)
                .padding()
            
            TextFieldView(placeholder: "Enter reminder description", text: $reminderViewModel.reminderDescription)
                .padding()
            
            DatePicker("Enter reminder date: ", selection: $reminderViewModel.reminderDate)
                .datePickerStyle(.compact)
                .padding()
            
            Toggle("Enable recurrence", isOn: $reminderViewModel.isOn)
                .padding()
            
            Picker("Recurrence:", selection: $reminderViewModel.reminderRecurrence) {
                ForEach(Recurrence.allCases, id: \.self) { option in
                    Text(option.displayText)
                }
            }
            .disabled(!reminderViewModel.disableRecurrence())
            .padding()
            
            if reminderViewModel.isOn, case .custom = reminderViewModel.reminderRecurrence {
                HStack {
                    TextFieldView(placeholder: "Days:", text: Binding(
                        get: { String(reminderViewModel.days) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                reminderViewModel.days = intValue
                            } else {
                                reminderViewModel.days = 0
                            }
                        }
                    ))
                    .keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Weeks:", text: Binding(
                        get: { String(reminderViewModel.weeks) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                reminderViewModel.weeks = intValue
                            } else {
                                reminderViewModel.weeks = 0
                            }
                        }
                    ))
                    .keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Months:", text: Binding(
                        get: { String(reminderViewModel.months) },
                        set: {
                            let filtered = $0.filter { $0.isNumber }
                            if let intValue = Int(filtered), intValue >= 0 {
                                reminderViewModel.months = intValue
                            } else {
                                reminderViewModel.months = 0
                            }
                        }
                    ))
                    .keyboardType(.numberPad)
                }
                .padding()
            }
            
            Button {
                var recurrence = reminderViewModel.isOn ? reminderViewModel.reminderRecurrence : nil
                
                reminderViewModel.addReminder(reminder: ReminderModel(
                    title: reminderViewModel.reminderTitle,
                    description: reminderViewModel.reminderDescription,
                    date: reminderViewModel.reminderDate,
                    recurrence: recurrence
                ))
            } label: {
                Label("Add reminder", systemImage: "plus.app")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
            .disabled(!reminderViewModel.validate())
            
            Spacer()
        }
    }
}

#Preview {
    CreateReminderScreenView(reminderViewModel: ReminderViewModel())
}
