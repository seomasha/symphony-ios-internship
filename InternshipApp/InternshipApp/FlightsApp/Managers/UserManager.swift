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
            "profile_image_url": user?.user.profile?.imageURL(withDimension: 40)?.absoluteString ?? "https://firebasestorage.googleapis.com/v0/b/flights-app-643e1.appspot.com/o/airplane_icon.png?alt=media&token=f5269115-330a-471c-8609-4c82a44094b4",
            "date_created": Timestamp(),
            "email": auth.email!,
            "booked_flights": []
        ]
        
        do {
            try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
            print("Created user in the Database")
        } catch {
            print("\(error.localizedDescription)")
        }
        
        userViewModel.name = user?.user.profile?.givenName ?? userViewModel.name
        userViewModel.surname = user?.user.profile?.familyName ?? userViewModel.surname
        userViewModel.profileImageURL = user?.user.profile?.imageURL(withDimension: 40)?.absoluteString ?? userViewModel.profileImageURL
    }

    func getUser(userID: String) async throws -> DBUser? {
        do {
            let userData = try await Firestore.firestore().collection("users").document(userID).getDocument()

            guard let data = userData.data(), let userID = data["user_id"] as? String else {
                throw URLError(.badServerResponse)
            }

            let dateCreated = (data["date_created"] as? Timestamp)?.dateValue()
            let email = data["email"] as? String ?? "no-email@example.com"
            let name = data["name"] as? String ?? "No Name"
            let surname = data["surname"] as? String ?? "No Surname"
            let age = data["age"] as? Int ?? 0
            let faceIDEnabled = data["face_id_enabled"] as? Bool ?? false
            let profileImageURL = data["profile_image_url"] as? String ?? ""
            let bookedFlights = data["booked_flights"] as? [BookedFlightModel] ?? []

            return DBUser(userID: userID,
                          name: name,
                          surname: surname,
                          age: age,
                          email: email,
                          faceIDEnabled: faceIDEnabled,
                          dateCreated: dateCreated,
                          profileImageURL: profileImageURL, 
                          bookedFlights: bookedFlights)

        } catch {
            print("Failed to get user: \(error.localizedDescription)")
            throw error
        }
    }

    func updateUser(userID: String, updates: [String: Any]) async throws {
        do {
            try await Firestore.firestore().collection("users").document(userID).updateData(updates)
        } catch {
            print("Failed to update user: \(error.localizedDescription)")
            throw error
        }
    }
}
