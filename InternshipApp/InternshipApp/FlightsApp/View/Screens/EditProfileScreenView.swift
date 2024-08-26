//
//  EditProfileScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import SwiftUI
import PhotosUI

struct EditProfileScreenView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.lightgray).ignoresSafeArea()
                
                VStack {
                    VStack {
                        Spacer()
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.white)
                                    .padding(.horizontal)
                            }
                            .frame(width: 44)
                            
                            Spacer()
                            
                            Text("Edit profile")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .padding(.vertical)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.clear)
                                    .padding(.horizontal)
                            }
                            .frame(width: 44) // For centering the "Edit profile"
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .ignoresSafeArea(edges: .top)
                    
                    VStack(spacing: 24) {
                        PhotosPicker(selection: $userViewModel.selectedItem, matching: .images) {
                            VStack {
                                if let selectedImage = userViewModel.selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                } else if let imageURL = URL(string: userViewModel.profileImageURL) {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 100, height: 100)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .frame(width: 100, height: 100)
                                        case .failure:
                                            Image("airplaneIcon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .frame(width: 100, height: 100)
                                        @unknown default:
                                            Image("airplaneIcon")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .clipShape(Circle())
                                                .frame(width: 100, height: 100)
                                        }
                                    }
                                } else {
                                    Image("airplaneIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .frame(width: 100, height: 100)
                                }
                                
                                Text("Select Profile Image")
                                    .foregroundColor(.blue)
                            }
                        }
                        .onChange(of: userViewModel.selectedItem) { _, newItem in
                            Task {
                                if let selectedItem = newItem {
                                    if let data = try? await selectedItem.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        userViewModel.selectedImage = uiImage
                                    }
                                }
                            }
                        }
                        .padding()
                                    
                        
                        if let user = userViewModel.user {
                            VStack {
                                TextFieldInput(label: "Your name",
                                               placeholder: user.name,
                                               text: $userViewModel.name,
                                               iconName: "")
                                .padding(.horizontal)
                            }
                            
                            VStack {
                                TextFieldInput(label: "Your surname",
                                               placeholder: user.surname,
                                               text: $userViewModel.surname,
                                               iconName: "")
                                .padding(.horizontal)
                            }
                            
                            VStack {
                                NumberPickerInput(label: "Choose your number",
                                                  value: $userViewModel.age)
                            }
                        }
                        
                        ButtonView(title: "Save", style: .primary) {
                            Task {
                                do {
                                    try await userViewModel.uploadProfileImage()
                                                

                                    userViewModel.user?.name = userViewModel.name
                                    userViewModel.user?.surname = userViewModel.surname
                                    userViewModel.user?.age = userViewModel.age
                                    
                                    userViewModel.user?.profileImageURL = userViewModel.profileImageURL
                                    
                                    try await userViewModel.updateUser()
                                    
                                } catch {
                                    print("Error: \(error)")
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            userViewModel.name = userViewModel.user?.name ?? ""
            userViewModel.surname = userViewModel.user?.surname ?? ""
            userViewModel.age = userViewModel.user?.age ?? 0
            userViewModel.profileImageURL = userViewModel.user?.profileImageURL ?? ""
        }
    }
}

#Preview {
    EditProfileScreenView(userViewModel: UserViewModel())
}
