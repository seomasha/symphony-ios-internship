//
//  ReminderView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import SwiftUI

struct ReminderView: View {
    
    let reminder: ReminderModel
    
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(reminder.title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(reminder.description)
                .font(.subheadline)
            
            HStack {
                Text(reminderViewModel.formatDate(reminder.date))
                    .font(.caption)
                Spacer()
                Text(reminderViewModel.handleRecurrence(rec: reminder.recurrence?.displayText, days: reminder.days, weeks: reminder.weeks, months: reminder.months))
                    .font(.caption)
                Spacer()
            }
        }
        .padding()
        .background(.blue)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        .padding()
    }
}

#Preview {
    ReminderView(reminder: ReminderModel(title: "Test", description: "Test", date: Date(), recurrence: Recurrence.monthly, days: 2, weeks: 2, months: 2))
}
