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
}
