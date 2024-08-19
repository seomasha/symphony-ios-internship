//
//  ProfileScreenViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import Foundation
import _PhotosUI_SwiftUI

@MainActor
final class ProfileScreenViewModel: ObservableObject {
    @Published var name: String = "Sead Masetic"
    @Published var email: String = "sead@masetic.com"
    @Published var image: UIImage? = nil
    
    @Published var localName: String = "Sead Masetic"
    @Published var localEmail: String = "sead@masetic.com"
    @Published var localImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            guard imageSelection != nil else { return }
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    localImage = uiImage
                    return
                }
            }
        }
    }
    
    func updateProfile(name: String, email: String, image: UIImage) {
        self.name = name
        self.email = email
        self.image = image
     }
    
    func resetProfileData() {
        localName = name
        localEmail = email
        localImage = image
    }
    
    func validate() -> Bool {
        return validateName() && validateEmail()
    }
    
    func validateName() -> Bool {
        return !self.localName.isEmpty && self.localName.contains(" ")
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.localEmail)
    }
}
