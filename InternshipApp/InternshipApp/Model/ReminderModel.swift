//
//  Reminder.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import SwiftUI

struct ReminderModel: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let date: Date
    let recurrence: Recurrence?
}
