//
//  User.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let surname: String
    let email: String
    let password: String
}
