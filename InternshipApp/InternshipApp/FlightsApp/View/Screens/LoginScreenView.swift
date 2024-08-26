//
//  LoginScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct LoginScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(.blue)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("Login")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding()
                        
                        Text("Welcome back to the app")
                            .font(.callout)
                            .foregroundStyle(.white)
                    }
                    
                    VStack(alignment: .leading, spacing: 24) {
                        VStack {
                            TextFieldInput(label: "Email Address",
                                           placeholder: "Enter your email",
                                           text: $userViewModel.email,
                                           iconName: "")
                        }

                        VStack {
                            PasswordTextField(text: $userViewModel.password,
                                              label: "Forgot password?")
                        }
                        
                        CheckboxView(label: "Keep me signed in")
                        
                        VStack(spacing: 24) {
                            ButtonView(title: "Login",
                                       style: .primary,
                                       action: {
                                Task {
                                    do {
                                        if userViewModel.faceIDEnabled {
                                            try await userViewModel.authenticateWithFaceID()
                                        } else {
                                            try await userViewModel.signIn()
                                        }
                                    } catch {
                                        userViewModel.alertMessage = "You have provided false credentials"
                                        userViewModel.showAlert = true
                                    }
                                }
                            })
                            
                            Break(label: "or sign in with")

                            ButtonView(title: "Continue with Google",
                                       style: .secondary,
                                       action: {
                                
                                Task {
                                    do {
                                        try await userViewModel.signInWithGoogle()
                                        userViewModel.isSignedIn = true
                                    } catch {
                                        userViewModel.alertMessage = "Google Sign-In failed: \(error.localizedDescription)"
                                        userViewModel.showAlert = true
                                    }
                                }
                            }, leadingIcon: ImageResource.google)
                            
                            Button {

                            } label: {
                                NavigationLink(destination: RegistrationScreenView(userViewModel: userViewModel)) {
                                    Text("Create an account")
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
            .alert(isPresented: $userViewModel.showAlert) {
                Alert(title: Text("Login Error"),
                      message: Text(userViewModel.alertMessage),
                      dismissButton: .default(Text("OK")))
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    LoginScreenView(userViewModel: UserViewModel())
}
