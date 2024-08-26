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
                
                ScrollView {
                    VStack {
                        VStack {
                            Text("Register")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            Text("Create your account")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your name",
                                               placeholder: "Enter your name",
                                               text: $userViewModel.name,
                                               iconName: "")
                                if userViewModel.registrationAttempted && userViewModel.name.isEmpty {
                                    Text("Name is required")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your surname",
                                               placeholder: "Enter your surname",
                                               text: $userViewModel.surname,
                                               iconName: "")
                                if userViewModel.registrationAttempted && userViewModel.surname.isEmpty {
                                    Text("Surname is required")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                IntegerTextFieldInput(label: "Your age",
                                                      placeholder: "Enter your age",
                                                      value: $userViewModel.age,
                                                      iconName: "")
                                if userViewModel.registrationAttempted && userViewModel.age <= 0 {
                                    Text("Age must be greater than 0")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your email",
                                               placeholder: "Enter your email",
                                               text: $userViewModel.email,
                                               iconName: "")
                                
                                if userViewModel.registrationAttempted && !userViewModel.validateEmail() {
                                    Text("Email is invalid")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                PasswordTextField(text: $userViewModel.password)
                                
                                if userViewModel.registrationAttempted && !userViewModel.validatePassword() {
                                    Text("Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit, and a special character.")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(spacing: 24) {
                                ButtonView(title: "Register",
                                           style: .primary,
                                           action: {
                                    userViewModel.registrationAttempted = true

                                    if userViewModel.validate() {
                                        Task {
                                            do {
                                                try await userViewModel.signUp()
                                                print("Created account!")
                                                userViewModel.registrationAttempted = false
                                            } catch {
                                                userViewModel.alertMessage = "Failed to create account: \(error.localizedDescription)"
                                                userViewModel.showAlert = true
                                            }
                                        }
                                    } else {
                                        userViewModel.alertMessage = "Please ensure all fields are correctly filled out."
                                        userViewModel.showAlert = true
                                    }
                                })
                                .alert(isPresented: $userViewModel.showAlert) {
                                    Alert(title: Text("Registration Error"),
                                          message: Text(userViewModel.alertMessage),
                                          dismissButton: .default(Text("OK")))
                                }
                                
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
                
                if userViewModel.accountCreated {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.green)
                            .scaleEffect(userViewModel.accountCreated ? 1 : 0.5)
                            .opacity(userViewModel.accountCreated ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5), value: userViewModel.accountCreated)
                        
                        Text("Account Created!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                            .opacity(userViewModel.accountCreated ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5).delay(0.1), value: userViewModel.accountCreated)
                    }
                    .frame(maxWidth: 300, maxHeight: 300)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(40)
                    .shadow(radius: 10)
                    .transition(.opacity)
                    .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    RegistrationScreenView(userViewModel: UserViewModel())
}
