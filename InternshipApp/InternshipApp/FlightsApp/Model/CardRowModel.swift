//
//  CardRowModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import Foundation

struct CardRowModel: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let subtitle: String
    let warning: String
    let action: () -> Void
}
