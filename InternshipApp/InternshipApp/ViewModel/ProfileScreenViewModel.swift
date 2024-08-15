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
    @Published var name: String
    @Published var email: String
    @Published private(set) var image: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    var localName: String = ""
    var localEmail: String = ""
    var localImage: UIImage? = nil
    
    init(name: String = "Sead Masetic", email: String = "sead@masetic.com") {
        self.name = name
        self.email = email
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    image = uiImage
                    return
                }
            }
        }
    }
    
    func updateProfile(name: String, email: String, image: UIImage?) {
         self.name = name
         self.email = email
         self.image = image
     }
    
    func validate() -> Bool {
        return validateName() && validateEmail()
    }
    
    func validateName() -> Bool {
        return !self.name.isEmpty && self.name.contains(" ")
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.email)
    }
}
