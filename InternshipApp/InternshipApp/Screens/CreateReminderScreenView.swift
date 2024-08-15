
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
                    TextField("Days:", value: $reminderViewModel.days, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                    TextField("Weeks:", value: $reminderViewModel.weeks, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                    
                    TextField("Months:", value: $reminderViewModel.months, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                .padding()
            }
            
            Button {
                let recurrence = reminderViewModel.isOn ? reminderViewModel.reminderRecurrence : nil
                
                if reminderViewModel.days > 0 || reminderViewModel.weeks > 0 || reminderViewModel.months > 0 {
                    reminderViewModel.addReminder(reminder: ReminderModel(
                        title: reminderViewModel.reminderTitle,
                        description: reminderViewModel.reminderDescription,
                        date: reminderViewModel.reminderDate,
                        recurrence: recurrence,
                        days: reminderViewModel.days,
                        weeks: reminderViewModel.weeks,
                        months: reminderViewModel.months
                        ))
                }
                else {
                    reminderViewModel.addReminder(reminder: ReminderModel(
                                title: reminderViewModel.reminderTitle,
                                description: reminderViewModel.reminderDescription,
                                date: reminderViewModel.reminderDate,
                                recurrence: recurrence,
                                days: 0,
                                weeks: 0,
                                months: 0
                                ))
                }
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
