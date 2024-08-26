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
    
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return AuthDataResultModel(user: authDataResult.user)
        } catch {
            throw error
        }
    }
    
    func getAuthenticateduser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return AuthDataResultModel(user: authDataResult.user)
        } catch {
            throw error
        }
    }
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch {
            throw error
        }
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel{
        do {
            let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accesToken)
            return try await signInWithCredential(credential: credential)
        } catch {
            throw error
        }
    }
    
    func signInWithCredential(credential: AuthCredential) async throws -> AuthDataResultModel{
        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            return AuthDataResultModel(user: authDataResult.user)
        } catch {
            throw error
        }
    }
}
