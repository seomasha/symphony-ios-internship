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
import FirebaseFirestore
import FirebaseStorage
import _PhotosUI_SwiftUI

@MainActor
final class UserViewModel: ObservableObject {
    
    @Published var user: DBUser? = nil
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var age: Int = 0
    @Published var profileImageURL = ""
    @Published var faceIDEnabled: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var newPassword = ""
    
    private let minLength = 8
    private let uppercasePattern = "(?=.*[A-Z])"
    private let lowercasePattern = "(?=.*[a-z])"
    private let digitPattern = "(?=.*[0-9])"
    private let specialCharacterPattern = "(?=.*[!@#$%^&*()_+{}\\[\\]:;,.<>?~])"
    
    @Published var isSignedIn = false
    
    @Published var selectedImage: UIImage? = nil
    @Published var selectedItem: PhotosPickerItem? = nil
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var registrationAttempted: Bool = false
    @Published var accountCreated: Bool = false
    
    init() {
        self.name = user?.name ?? ""
        self.surname = user?.surname ?? ""
        self.age = user?.age ?? 0
        self.email = user?.email ?? ""
        self.faceIDEnabled = user?.faceIDEnabled ?? false
    }
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticateduser()
        do {
            self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
        } catch {
            print("Came across some issues while fetching the current user.")
        }
        
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
            "face_id_enabled": faceIDEnabled,
            "profile_image_url": profileImageURL
        ]
        
        do {
            try await UserManager.shared.updateUser(userID: userID, updates: updates)
        } catch {
            print("\(error)")
        }
    }
    
    func uploadProfileImage() async throws {
        guard let image = selectedImage else {
            throw URLError(.badServerResponse)
        }
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        guard let userID = user?.userID else {
            throw URLError(.badServerResponse)
        }
        let imageName = "profile_images/\(userID).jpg"
        let imageRef = storageRef.child(imageName)
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw URLError(.badServerResponse)
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata)
        
        let downloadURL = try await imageRef.downloadURL()
        
        self.profileImageURL = downloadURL.absoluteString
        
        let updates: [String: Any] = ["profile_image_url": profileImageURL]
        try await UserManager.shared.updateUser(userID: userID, updates: updates)
    }
    
    func updateImage(_ image: UIImage) {
        self.selectedImage = image
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            return
        }

        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult, userViewModel: self, user: nil)
        
        name = ""
        surname = ""
        age = 0
        email = ""
        password = ""
        
        isSignedIn = false
        
        accountCreated = true
        resetAccountCreatedState()
    }
    
    private func resetAccountCreatedState() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.accountCreated = false
        }
    }
    
    func signIn() async throws {
        do {
            guard !email.isEmpty, !password.isEmpty else {
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
        } catch {
            self.showAlert = true
            self.alertMessage = "Failed to sign in: \(error.localizedDescription)"
        }
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
        let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
       
        let userID = authDataResult.uid
        do {
            let existingUser = try await UserManager.shared.getUser(userID: userID)
            
            if existingUser != nil {
                self.user = existingUser
            } else {
                try await UserManager.shared.createNewUser(auth: authDataResult, userViewModel: self, user: gidSignInResult)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
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
