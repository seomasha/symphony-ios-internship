//
//  DBUser.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import Foundation

struct DBUser {
    let userID: String
    let name: String
    let surname: String
    let age: Int
    let email: String?
    let faceIDEnabled: Bool
    let dateCreated: Date?
}
