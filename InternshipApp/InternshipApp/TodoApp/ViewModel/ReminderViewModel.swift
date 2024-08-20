import Foundation
import UserNotifications

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
    
    func handleRecurrence(rec: String?, days: Int, weeks: Int, months: Int) -> String {
        if rec == "Daily" {
            return "Daily"
        } else if rec == "Weekly" {
            return "Weekly"
        } else if rec == "Monthly" {
            return "Monthly"
        } else if rec == "Custom" {
            var components: [String] = []
            if days > 0 {
                components.append("\(days) day\(days > 1 ? "s" : "")")
            }
            if weeks > 0 {
                components.append("\(weeks) week\(weeks > 1 ? "s" : "")")
            }
            if months > 0 {
                components.append("\(months) month\(months > 1 ? "s" : "")")
            }
            return components.joined(separator: ", ")
        }
        return "No recurrence"
    }
    
    func scheduleNotification(reminder: ReminderModel) {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = reminder.description
        content.sound = .default
        
        var trigger: UNNotificationTrigger?
        
        if let recurrence = reminder.recurrence {
            switch recurrence {
            case .daily:
                trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: Calendar.current.component(.hour, from: reminder.date), 
                                                                                     minute: Calendar.current.component(.minute, from: reminder.date)),
                                                        repeats: true)
            case .weekly:
                trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour: Calendar.current.component(.hour, from: reminder.date),
                                                                                     minute: Calendar.current.component(.minute, from: reminder.date),
                                                                                     weekday: Calendar.current.component(.weekday, from: reminder.date)),
                                                        repeats: true)
            case .monthly:
                trigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(day: Calendar.current.component(.day, from: reminder.date), 
                                                                                     hour: Calendar.current.component(.hour, from: reminder.date),
                                                                                     minute: Calendar.current.component(.minute, from: reminder.date)),
                                                        repeats: true)
            case .custom:
                trigger = createCustomTrigger(for: reminder)
            }
        } else {
            let timeInterval = reminder.date.timeIntervalSinceNow
            if timeInterval > 0 {
                trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            }
        }
        
        if let trigger = trigger {
            let request = UNNotificationRequest(identifier: reminder.id.uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        }
    }
    
    private func createCustomTrigger(for reminder: ReminderModel) -> UNNotificationTrigger? {
        var dateComponents = DateComponents()
        dateComponents.day = Calendar.current.component(.day, from: reminder.date) + reminder.days
        dateComponents.weekOfMonth = Calendar.current.component(.weekOfMonth, from: reminder.date) + reminder.weeks
        dateComponents.month = Calendar.current.component(.month, from: reminder.date) + reminder.months
        dateComponents.hour = Calendar.current.component(.hour, from: reminder.date)
        dateComponents.minute = Calendar.current.component(.minute, from: reminder.date)
        
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }
    
    func addReminder(reminder: ReminderModel) {
        reminders.append(reminder)
        scheduleNotification(reminder: reminder)
        
        reminderTitle = ""
        reminderDescription = ""
        reminderDate = Date()
        reminderRecurrence = .daily
        isOn = false
        days = 0
        weeks = 0
        months = 0
        
        isPresented = false
    }
    
    func handleAddReminder() {
        let recurrence = isOn ? reminderRecurrence : nil
        
        let newReminder = ReminderModel(
            title: reminderTitle,
            description: reminderDescription,
            date: reminderDate,
            recurrence: recurrence,
            days: days > 0 ? days : 0,
            weeks: weeks > 0 ? weeks : 0,
            months: months > 0 ? months : 0
        )
        
        addReminder(reminder: newReminder)
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
