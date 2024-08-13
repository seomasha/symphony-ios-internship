//
//  EditProfileView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @State private var localName: String
    @State private var localEmail: String
    @State private var localImage: UIImage?
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @ObservedObject var profileViewModel: ProfileScreenViewModel = ProfileScreenViewModel()
    
    init(profileViewModel: ProfileScreenViewModel) {
        _profileViewModel = ObservedObject(wrappedValue: profileViewModel)
        _localName = State(initialValue: profileViewModel.name)
        _localEmail = State(initialValue: profileViewModel.email)
        _localImage = State(initialValue: profileViewModel.image)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $profileViewModel.imageSelection, matching: .images) {
                    if let image = profileViewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .foregroundStyle(.black)
                    }
                }
                
                VStack(alignment: .leading) {
                    TextFieldView(placeholder: "Your name:", text: $profileViewModel.name)
                        .border(!validateName() ? .red : .gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 10)))
                    if(!validateName()) {
                        Text("You should enter your name and surname")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    
                    TextFieldView(placeholder: "Your email:", text: $profileViewModel.email)
                        .border(!validateEmail() ? .red : .gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 10)))
                    
                    if(!validateEmail()) {
                        Text("You should enter your email and it needs to have an @ symbol")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }.padding()
                
                Button(action: {
                    profileViewModel.updateProfile(name: localName, email: localEmail, image: localImage)
                }, label: {
                    NavigationLink(destination: ProfileScreenView(profileViewModel: profileViewModel, taskViewModel: taskViewModel)) {
                        Label("Save", systemImage: "pencil")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                }).buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    .disabled(!validate())
            }
            .padding()
            
            
            Spacer()
        }
        .navigationTitle("Edit profile")
    }
    
    func validate() -> Bool {
        return validateName() && validateEmail()
    }
    
    func validateName() -> Bool {
        return !profileViewModel.name.isEmpty && profileViewModel.name.contains(" ")
    }
    
    func validateEmail() -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: profileViewModel.email)
    }
}

#Preview {
    EditProfileView(profileViewModel: ProfileScreenViewModel())
}
