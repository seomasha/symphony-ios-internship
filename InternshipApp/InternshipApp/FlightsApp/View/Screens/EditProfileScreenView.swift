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
                            if let imageUrl = URL(string: userViewModel.profileImageURL) {
                                AsyncImage(url: imageUrl) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 100, height: 100)
                            } else {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                            }
                        }
                        .onChange(of: userViewModel.selectedItem) { newItem in
                            Task {
                                if let selectedItem = newItem {
                                    let data = try? await selectedItem.loadTransferable(type: Data.self)
                                    
                                    if let data, let uiImage = UIImage(data: data) {
                                        userViewModel.updateImage(uiImage)
                                    }
                                }
                            }
                        }
                        
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
                                IntegerTextFieldInput(label: "Your name",
                                                      placeholder: "\(user.age)",
                                               value: $userViewModel.age,
                                               iconName: "")
                                .padding(.horizontal)
                            }
                        }
                        
                        ButtonView(title: "Edit", style: .primary) {
                            Task {
                                do {
                                    try await userViewModel.updateUser()
                                    try await userViewModel.uploadProfileImage()
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
        }
    }
}

#Preview {
    EditProfileScreenView(userViewModel: UserViewModel())
}
