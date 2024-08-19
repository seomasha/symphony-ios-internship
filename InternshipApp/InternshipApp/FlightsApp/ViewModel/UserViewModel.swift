//
//  UserViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation

final class UserViewModel: ObservableObject {
    var users: [User] = []
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    func addUser(user: User) {
        users.append(user)
    }
}
