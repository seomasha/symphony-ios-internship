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
}
