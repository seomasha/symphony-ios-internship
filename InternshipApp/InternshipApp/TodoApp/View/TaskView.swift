//
//  TaskView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

struct TaskView: View {
    
    let taskName: String
    let taskDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(taskName)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            Text(taskDescription)
                .font(.subheadline)
        }
    }
}

#Preview {
    TaskView(taskName: "Test", taskDescription: "Testiranje")
}
