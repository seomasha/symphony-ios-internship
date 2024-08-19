//
//  RegistrationScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct RegistrationScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(.blue)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Register")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                        
                        Text("Create your account")
                            .font(.callout)
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading) {
                            TextFieldInput(label: "Your name",
                                           placeholder: "Enter your name",
                                           text: $userViewModel.name,
                                           iconName: "",
                                           password: false)
                            
                            if !userViewModel.isValid && userViewModel.name.isEmpty {
                                Text("Name is invalid")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            TextFieldInput(label: "Your surname",
                                           placeholder: "Enter your surname",
                                           text: $userViewModel.surname,
                                           iconName: "",
                                           password: false)
                            
                            if !userViewModel.isValid && userViewModel.surname.isEmpty {
                                Text("Surname is invalid")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            TextFieldInput(label: "Your email",
                                           placeholder: "Enter your email",
                                           text: $userViewModel.email,
                                           iconName: "",
                                           password: false)
                            
                            if !userViewModel.isValid && !userViewModel.validateEmail() {
                                Text("Email is invalid")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            TextFieldInput(label: "Password",
                                           placeholder: "Enter your password",
                                           text: $userViewModel.password,
                                           iconName: "eye",
                                           password: true)
                            
                            if !userViewModel.isValid && !userViewModel.validatePassword() {
                                Text("Password is invalid")
                                    .foregroundStyle(.red)
                                    .font(.footnote)
                            }
                        }
                        
                        VStack(spacing: 24) {
                            ButtonView(title: "Register", 
                                       style: .primary,
                                       action: {
                                
                                if userViewModel.validate() {
                                    userViewModel.addUser(user: User(name: userViewModel.name,
                                                                     surname: userViewModel.surname,
                                                                     email: userViewModel.email,
                                                                     password: userViewModel.password))
                                    userViewModel.isValid = true
                                } else {
                                    userViewModel.isValid = false
                                }
                            })
                            
                            Button {

                            } label: {
                                NavigationLink(destination: LoginScreenView(userViewModel: UserViewModel())) {
                                    Text("Already have an account?")
                                }
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(.red)
                            .fontWeight(.bold)
                            .padding()
                        }
                    }
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 10)))
                    .padding()
                }
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    RegistrationScreenView(userViewModel: UserViewModel())
}
