//
//  CreateReminderViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import Foundation

final class CreateReminderViewModel: ObservableObject {
    @Published var reminderTitle: String = ""
    @Published var reminderDescription: String = ""
    @Published var reminderDate: Date = Date()
    
    @Published var isOn: Bool = false
    @Published var selectedOption = "Daily"
    @Published var options = ["Daily", "Weekly", "Monthly", "Custom"]
    
    @Published var days: Int = 0
    @Published var weeks: Int = 0
    @Published var months: Int = 0
    
    func disableRecurrence() -> Bool {
        return isOn
    }
    
    func validate() -> Bool {
        var isValid = true
        
        if reminderTitle.isEmpty || reminderDescription.isEmpty {
            isValid = false
        }
        
        if selectedOption == "Custom" {
            if days == 0 && weeks == 0 && months == 0 {
                isValid = false
            }
        }
        
        return isValid
    }
}

