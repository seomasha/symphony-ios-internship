//
//  UserManager.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import Foundation
import FirebaseFirestore
import FirebaseCore

final class UserManager {
    
    static let shared = UserManager()
    
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel, userViewModel: UserViewModel) async throws {
        
        var userData: [String: Any] = await [
            "user_id": auth.uid,
            "name": userViewModel.name,
            "surname": userViewModel.surname,
            "age": userViewModel.age,
            "face_id_enabled": userViewModel.faceIDEnabled,
            "date_created": Timestamp(),
            "email": auth.email!
        ]
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
        
    }
    
    func getUser(userID: String) async throws -> DBUser {
        let userData = try await Firestore.firestore().collection("users").document(userID).getDocument()
        
        guard let data = userData.data(), let userID = data["user_id"] as? String else {
            throw URLError(.badServerResponse)
        }
        
        let dateCreated = data["date_created"] as? Date
        let email = data["email"] as? String
        let name = data["name"] as? String
        let surname = data["surname"] as? String
        let age = data["age"] as? Int
        let faceIDEnabled = data["face_id_enabled"] as? Bool
        
        return DBUser(userID: userID,
                      name: name!,
                      surname: surname!,
                      age: age!,
                      email: email,
                      faceIDEnabled: faceIDEnabled!,
                      dateCreated: dateCreated)
    }
}
