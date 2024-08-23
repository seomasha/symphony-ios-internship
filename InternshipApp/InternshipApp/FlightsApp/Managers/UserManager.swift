//
//  UserManager.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import Foundation
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn

@MainActor
final class UserManager {
    
    static let shared = UserManager()
    
    private init() { }
    
    func createNewUser(auth: AuthDataResultModel, userViewModel: UserViewModel, user: GIDSignInResult?) async throws {
        
        let userData: [String: Any] = [
            "user_id": auth.uid,
            "name": user?.user.profile?.givenName ?? userViewModel.name,
            "surname": user?.user.profile?.familyName ?? userViewModel.surname,
            "age": userViewModel.age,
            "face_id_enabled": userViewModel.faceIDEnabled,
            "profile_image_url": user?.user.profile?.imageURL(withDimension: 40)?.absoluteString ?? userViewModel.profileImageURL,
            "date_created": Timestamp(),
            "email": auth.email!
        ]
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
        
        DispatchQueue.main.async {
            userViewModel.name = user?.user.profile?.givenName ?? userViewModel.name
            userViewModel.surname = user?.user.profile?.familyName ?? userViewModel.surname
            userViewModel.profileImageURL = user?.user.profile?.imageURL(withDimension: 40)?.absoluteString ?? userViewModel.profileImageURL
        }
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
        let profileImageURL = data["profile_image_url"] as? String
        
        return DBUser(userID: userID,
                      name: name!,
                      surname: surname!,
                      age: age!,
                      email: email,
                      faceIDEnabled: faceIDEnabled!,
                      dateCreated: dateCreated,
                      profileImageURL: profileImageURL!)
    }
    
    func updateUser(userID: String, updates: [String: Any]) async throws {
        try await Firestore.firestore().collection("users").document(userID).updateData(updates)
    }
}
