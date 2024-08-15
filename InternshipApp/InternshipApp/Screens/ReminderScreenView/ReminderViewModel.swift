//
//  ReminderScreenViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import Foundation

final class ReminderViewModel: ObservableObject {
    @Published var reminders: [ReminderModel] = []
    @Published var isPresented: Bool = false
    
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
}
