//
//  DBUser.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import Foundation
import FirebaseCore

struct DBUser {
    var userID: String
    var name: String
    var surname: String
    var age: Int
    var email: String?
    var faceIDEnabled: Bool
    var dateCreated: Date?
    var profileImageURL: String?
}
