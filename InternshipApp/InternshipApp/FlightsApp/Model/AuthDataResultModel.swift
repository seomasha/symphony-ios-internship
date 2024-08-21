//
//  AuthDataResultModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 20. 8. 2024..
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
