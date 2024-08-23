//
//  UserViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import LocalAuthentication

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published var user: DBUser? = nil
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: Int = 0
    @Published var faceIDEnabled: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var newPassword = ""
    
    @Published var isValid: Bool = true
    private let minLength = 8
    private let uppercasePattern = "(?=.*[A-Z])"
    private let lowercasePattern = "(?=.*[a-z])"
    private let digitPattern = "(?=.*[0-9])"
    private let specialCharacterPattern = "(?=.*[!@#$%^&*()_+{}\\[\\]:;,.<>?~])"
    
    @Published var isSignedIn = false
    
    init() {
        self.name = user?.name ?? ""
        self.surname = user?.surname ?? ""
        self.age = user?.age ?? 0
        self.email = user?.email ?? ""
        self.faceIDEnabled = user?.faceIDEnabled ?? false
    }
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticateduser()
        self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
        
        self.faceIDEnabled = user?.faceIDEnabled ?? false
    }
    
    func updateUser() async throws {
        guard let userID = user?.userID else {
            throw URLError(.badServerResponse)
        }
        
        let updates: [String: Any] = [
            "name": name,
            "surname": surname,
            "age": age,
            "face_id_enabled": faceIDEnabled
        ]
        
        try await UserManager.shared.updateUser(userID: userID, updates: updates)
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            isValid = false
            return
        }

        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult, userViewModel: self, user: nil)
        name = ""
        surname = ""
        age = 0
        email = ""
        password = ""
    }
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            isValid = false
            isSignedIn = false
            return
        }
        
        try await AuthenticationManager.shared.signIn(email: email, password: password)
        
        let authDataResult = try AuthenticationManager.shared.getAuthenticateduser()
        user = try await UserManager.shared.getUser(userID: authDataResult.uid)
        
        if user?.faceIDEnabled == true {
            try await authenticateWithFaceID()
        }
        
        isSignedIn = true
    }
    
    func signInWithGoogle() async throws {

        guard let topVC = Utilities.shared.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResult.user.accessToken.tokenString
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accesToken: accessToken)
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signOut() {
        try? AuthenticationManager.shared.signOut()
        isSignedIn = false
        email = ""
        password = ""
        user = nil
    }
    
    func changePassword(pass: String) async throws {
        guard let user = Auth.auth().currentUser  else {
            throw URLError(.badServerResponse)
        }
        
        try await user.updatePassword(to: pass)
        password = newPassword
        newPassword = ""
    }
    
    func toggleFaceID() {
        faceIDEnabled.toggle()
    }
    
    func saveFaceIDPreference() async throws {
        guard let userID = user?.userID else {
            throw URLError(.badServerResponse)
        }
        
        let updates: [String: Any] = ["face_id_enabled": faceIDEnabled]
        try await UserManager.shared.updateUser(userID: userID, updates: updates)
    }
    
    func validatePassword() -> Bool {
        let lengthValid = password.count >= minLength
        let uppercaseValid = matchesPattern(password, pattern: uppercasePattern)
        let lowercaseValid = matchesPattern(password, pattern: lowercasePattern)
        let digitValid = matchesPattern(password, pattern: digitPattern)
        let specialCharacterValid = matchesPattern(password, pattern: specialCharacterPattern)
        
        return lengthValid && uppercaseValid && lowercaseValid && digitValid && specialCharacterValid
    }
    
    private func matchesPattern(_ string: String, pattern: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: string.utf16.count)
        let match = regex?.firstMatch(in: string, options: [], range: range)
        return match != nil
    }
    
    func matchingPass() -> Bool {
        return newPassword == password
    }
    
    func validate() -> Bool {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        
        return isEmailValid && isPasswordValid
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.email)
    }

    func authenticateWithFaceID() async throws {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate using Face ID"

            try await withCheckedThrowingContinuation { continuation in
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        continuation.resume()
                    } else {
                        continuation.resume(throwing: authenticationError ?? NSError(domain: "AuthenticationFailed", code: -1, userInfo: nil))
                    }
                }
            }
        } else {
            if let error = error {
                throw error
            } else {
                throw NSError(domain: "FaceIDNotAvailable", code: -1, userInfo: [NSLocalizedDescriptionKey: "Face ID is not available on this device."])
            }
        }
    }

}
