import Foundation

final class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReminderModel] = []
    @Published var isPresented: Bool = false
    
    @Published var reminderTitle: String = ""
    @Published var reminderDescription: String = ""
    @Published var reminderDate: Date = Date()
    @Published var reminderRecurrence: Recurrence = .daily
    
    @Published var isOn: Bool = false
    @Published var days: Int = 0
    @Published var weeks: Int = 0
    @Published var months: Int = 0
    
    func addReminder(reminder: ReminderModel) {
        reminders.append(reminder)
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: date)
        
        return "\(dateString) at \(timeString)"
    }
    
    func disableRecurrence() -> Bool {
        return isOn
    }
    
    func validate() -> Bool {
        var isValid = true
        
        if reminderTitle.isEmpty || reminderDescription.isEmpty {
            isValid = false
        }
        
        if case .custom = reminderRecurrence {
            if days == 0 && weeks == 0 && months == 0 {
                isValid = false
            }
        }
        
        return isValid
    }
}
