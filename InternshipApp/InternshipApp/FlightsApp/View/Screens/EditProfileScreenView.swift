//
//  EditProfileScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import SwiftUI

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
