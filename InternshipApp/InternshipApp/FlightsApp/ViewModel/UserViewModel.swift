//
//  UserViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation

@MainActor
final class UserViewModel: ObservableObject {
    var users: [UserModel] = []
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isValid: Bool = true
    private let minLength = 8
    private let uppercasePattern = "(?=.*[A-Z])"
    private let lowercasePattern = "(?=.*[a-z])"
    private let digitPattern = "(?=.*[0-9])"
    private let specialCharacterPattern = "(?=.*[!@#$%^&*()_+{}\\[\\]:;,.<>?~])"
    
    func addUser(user: UserModel) {
        users.append(user)
        
        email = ""
        password = ""
    }
    
    func signIn() {
        guard !email.isEmpty, !password.isEmpty else {
            isValid = false
            return
        }
        
        Task {
            do {
                let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
                print(returnedUserData)
            } catch {
                print("Error: \(error)")
            }
        }
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
}
