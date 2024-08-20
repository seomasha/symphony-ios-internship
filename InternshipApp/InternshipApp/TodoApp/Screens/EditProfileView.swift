//
//  EditProfileView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @ObservedObject var taskViewModel: TaskViewModel = TaskViewModel()
    @ObservedObject var profileViewModel: ProfileScreenViewModel = ProfileScreenViewModel()
    @ObservedObject var reminderViewModel: ReminderViewModel = ReminderViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $profileViewModel.imageSelection, matching: .images) {
                    if let image = profileViewModel.localImage {
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
                    TextFieldView(placeholder: "Your name:", text: $profileViewModel.localName)
                        .border(!profileViewModel.validateName() ? .red : .gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 10)))
                    if(!profileViewModel.validateName()) {
                        Text("You should enter your name and surname")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                    
                    TextFieldView(placeholder: "Your email:", text: $profileViewModel.localEmail)
                        .border(!profileViewModel.validateEmail() ? .red : .gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 4, height: 10)))
                    
                    if(!profileViewModel.validateEmail()) {
                        Text("You should enter your email and it needs to have an @ symbol")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }.padding()
                
                Button(action: {
                    profileViewModel.updateProfile(name: profileViewModel.localName, 
                                                   email: profileViewModel.localEmail,
                                                   image: profileViewModel.localImage!)
                    
                    dismiss()
                }, label: {
                    Label("Save", systemImage: "pencil")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }).buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding()
                    .disabled(!profileViewModel.validate())
            }
            .padding()
            .onAppear {
                profileViewModel.resetProfileData()
            }
            
            
            Spacer()
        }
        .navigationTitle("Edit profile")
        .onDisappear {
            if !profileViewModel.validate() {
                profileViewModel.resetProfileData()
            }
        }
    }
}

#Preview {
    EditProfileView(profileViewModel: ProfileScreenViewModel())
}
