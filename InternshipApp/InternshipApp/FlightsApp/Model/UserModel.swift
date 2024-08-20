//
//  User.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let email: String
    let password: String
}
