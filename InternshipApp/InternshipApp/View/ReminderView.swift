//
//  ReminderView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 14. 8. 2024..
//

import SwiftUI

struct ReminderView: View {
    
    let reminderTitle: String
    let reminderDescription: String
    let reminderDate: Date
    let reminderRecurrence: Recurrence?
    
    @ObservedObject var reminderViewModel = ReminderViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(reminderTitle)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(reminderDescription)
                .font(.subheadline)
            
            HStack {
                Text(reminderViewModel.formatDate(reminderDate))
                    .font(.caption)
                Spacer()
                Text(reminderRecurrence?.displayResult ?? "No recurrence")
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
    ReminderView(reminderTitle: "Reminder title", reminderDescription: "Description", reminderDate: Date(), reminderRecurrence: nil)
}
