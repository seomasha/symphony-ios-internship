//
//  UserViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import Foundation

final class UserViewModel: ObservableObject {
    var users: [User] = []
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isValid: Bool = true
    private let uppercasePattern = "(?=.*[A-Z])"
    private let lowercasePattern = "(?=.*[a-z])"
    private let digitPattern = "(?=.*[0-9])"
    private let specialCharacterPattern = "(?=.*[!@#$%^&*()_+{}\\[\\]:;,.<>?~])"
    
    func addUser(user: User) {
        users.append(user)
        
        name = ""
        surname = ""
        email = ""
        password = ""
    }
    
    private let minLength = 8
    
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
        let isNameValid = !name.isEmpty
        let isSurnameValid = !surname.isEmpty
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        
        return isNameValid && isSurnameValid && isEmailValid && isPasswordValid
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.email)
    }
}
