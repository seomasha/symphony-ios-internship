//
//  CardViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import Foundation

final class CardViewModel: ObservableObject {
    @Published var profileRows: [CardRowModel] = [
        CardRowModel(icon: "person", 
                     title: "My account",
                     subtitle: "Make changes to your account",
                     warning: "",
                     action: { print("My account") }),
        
        CardRowModel(icon: "lock", 
                     title: "Face ID",
                     subtitle: "Manage your device security",
                     warning: "",
                     action: { print("Face ID") }),
        
        CardRowModel(icon: "pencil.line", 
                     title: "Change password",
                     subtitle: "Change the password of your account",
                     warning: "",
                     action: { print("Change pass") }),
        
        CardRowModel(icon: "questionmark.circle.fill",
                     title: "FAQ",
                     subtitle: "Frequently asked questions",
                     warning: "",
                     action: { print("FAQ") }),
        
        CardRowModel(icon: "rectangle.portrait.and.arrow.right", 
                     title: "Log out",
                     subtitle: "Go back to the login screen",
                     warning: "",
                     action: { print("Log out") }),
    ]
}
