//
//  TaskView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

struct TaskModel: Identifiable, Equatable {
    let id = UUID()
    let taskName: String
    let taskDescription: String
    
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        return lhs.taskName == rhs.taskName
    }
}
