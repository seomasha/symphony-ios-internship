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
    
    @Published var navigateToLogin = false
    
    @Published var bookedFlights: [BookedFlightModel] = []
    
    init() {
        self.name = user?.name ?? ""
        self.surname = user?.surname ?? ""
        self.age = user?.age ?? 0
        self.email = user?.email ?? ""
        self.faceIDEnabled = user?.faceIDEnabled ?? false
    }
    
    func loadCurrentUser() async throws {
        do {
            let authDataResult = try AuthenticationManager.shared.getAuthenticateduser()
            self.user = try await UserManager.shared.getUser(userID: authDataResult.uid)
            
            self.faceIDEnabled = user?.faceIDEnabled ?? false
        } catch {
            print("\(error.localizedDescription)")
        }
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
    
    func uploadProfileImage(_ image: UIImage) async throws {
        do {
            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                throw URLError(.badServerResponse)
            }
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            
            guard let userID = user?.userID else {
                throw URLError(.badServerResponse)
            }
            let imageName = "profile_images/\(userID).jpg"
            let imageRef = storageRef.child(imageName)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            imageRef.putData(imageData, metadata: metadata)
            
            let downloadURL = try await imageRef.downloadURL()
            
            self.profileImageURL = downloadURL.absoluteString
            
            let updates: [String: Any] = ["profile_image_url": profileImageURL]
            try await UserManager.shared.updateUser(userID: userID, updates: updates)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
    func updateImage(_ image: UIImage) {
        self.selectedImage = image
    }
    
    func signUp() async throws {
        do {
            guard !email.isEmpty, !password.isEmpty else {
                return
            }
            
            let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
            try await UserManager.shared.createNewUser(auth: authDataResult, userViewModel: self, user: nil)
            
            self.name = ""
            self.surname = ""
            self.age = 0
            self.email = ""
            self.password = ""
            
            self.isSignedIn = false
            
            self.accountCreated = true
            resetAccountCreatedState()
        } catch {
            print("\(error.localizedDescription)")
        }
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
            isSignedIn = false
        }
    }
    
    func signInWithGoogle() async throws {
        guard let topVC = Utilities.shared.topViewController() else {
            print("Failed to find top view controller.")
            throw URLError(.cannotFindHost)
        }
        
        do {
            let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
            
            guard let idToken = gidSignInResult.user.idToken?.tokenString else {
                print("Failed to retrieve ID token.")
                throw URLError(.badServerResponse)
            }
            
            let accessToken = gidSignInResult.user.accessToken.tokenString
            let tokens = GoogleSignInResultModel(idToken: idToken, accesToken: accessToken)
            let authDataResult = try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
            
            let userID = authDataResult.uid
            print("Attempting to fetch user with userID: \(userID)")
            
            do {
                let existingUser = try await UserManager.shared.getUser(userID: userID)
                self.user = existingUser
                print("User fetched successfully: \(String(describing: existingUser))")
            } catch {
                print("Failed to fetch user: \(error.localizedDescription). Creating a new user.")
                try await UserManager.shared.createNewUser(auth: authDataResult, userViewModel: self, user: gidSignInResult)
                print("New user created successfully.")
            }
            
        } catch let error as URLError {
            print("URLError occurred: \(error.code.rawValue) - \(error.localizedDescription)")
            throw error
        } catch let error as NSError {
            print("NSError occurred: \(error.domain) \(error.code) - \(error.localizedDescription)")
            throw error
        } catch {
            print("Unexpected error occurred: \(error.localizedDescription)")
            throw error
        }
    }
    
    func signOut() {
        try? AuthenticationManager.shared.signOut()
        isSignedIn = false
        navigateToLogin = true
        email = ""
        password = ""
        bookedFlights = []
        user = nil
    }
    
    func changePassword(pass: String) async throws {
        do {
            guard let user = Auth.auth().currentUser  else {
                throw URLError(.badServerResponse)
            }
            
            try await user.updatePassword(to: pass)
            password = newPassword
            newPassword = ""
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func toggleFaceID() {
        faceIDEnabled.toggle()
    }
    
    func saveFaceIDPreference() async throws {
        do {
            guard let userID = user?.userID else {
                throw URLError(.badServerResponse)
            }
            
            let updates: [String: Any] = ["face_id_enabled": faceIDEnabled]
            try await UserManager.shared.updateUser(userID: userID, updates: updates)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func addFlight(flightViewModel: FlightViewModel) async throws {
        let price = flightViewModel.selectedFlightOffer?.price ?? 0
        let date = flightViewModel.selectedFlightOffer?.date ?? Date()
        let departureCode = flightViewModel.selectedFlightOffer?.departureCode ?? ""
        let arrivalCode = flightViewModel.selectedFlightOffer?.arrivalCode ?? ""
        let airCompany = flightViewModel.selectedFlightOffer?.airCompany ?? ""
        
        let bookedFlight = BookedFlightModel(price: price,
                                                 date: date,
                                                 departureCode: departureCode,
                                                 arrivalCode: arrivalCode,
                                                 airCompany: airCompany)
        
        do {
            guard let userID = user?.userID else {
                throw URLError(.badServerResponse)
            }
            
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(userID)
            
            try await userRef.updateData([
                "booked_flights": FieldValue.arrayUnion([[
                    "price": bookedFlight.price,
                    "date": bookedFlight.date,
                    "departureCode": bookedFlight.departureCode,
                    "arrivalCode": bookedFlight.arrivalCode,
                    "airCompany": bookedFlight.airCompany
                ]])
            ])
            
        } catch {
            print("Error adding flight: \(error.localizedDescription)")
        }
    }
    
    func fetchBookedFlights() async throws {
        guard let userID = user?.userID else {
            throw URLError(.badServerResponse)
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        
        do {
            let documentSnapshot = try await userRef.getDocument()
            guard let data = documentSnapshot.data(),
                  let bookedFlightsData = data["booked_flights"] as? [[String: Any]] else {
                print("No booked flights found.")
                return
            }
            
            self.bookedFlights = bookedFlightsData.compactMap { flightData in
                guard let price = flightData["price"] as? Int,
                      let timestamp = flightData["date"] as? Timestamp,
                      let departureCode = flightData["departureCode"] as? String,
                      let arrivalCode = flightData["arrivalCode"] as? String,
                      let airCompany = flightData["airCompany"] as? String else {
                    return nil
                }
                
                let date = timestamp.dateValue()
                
                return BookedFlightModel(price: price, date: date, departureCode: departureCode, arrivalCode: arrivalCode, airCompany: airCompany)
            }
            
        } catch {
            print("Error fetching booked flights: \(error.localizedDescription)")
            throw error
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
