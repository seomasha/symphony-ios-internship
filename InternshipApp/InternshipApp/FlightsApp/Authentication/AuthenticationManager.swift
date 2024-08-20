//
//  AuthenticationManager.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 20. 8. 2024..
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    
    private init() { }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func getAuthenticateduser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
