//
//  LoginScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct LoginScreenView: View {
    
    @State var email: String = ""
    
    var body: some View {
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
                        TextFieldInput(label: "Email Address", placeholder: "Enter your email", text: email, iconName: "", password: false)
                    }

                    VStack {
                        TextFieldInput(label: "Password", placeholder: "Enter your password", text: email, iconName: "eye", secondaryText: "Forgot Password?", password: true)
                    }
                    
                    
                    CheckboxView(label: "Keep me signed in")
                    
                    VStack(spacing: 24) {
                        ButtonView(title: "Login", style: .primary, action: {
                            print("Primary button tapped")
                        })
                        
                        HStack {
                            Spacer()
                            Divider()
                                .rotationEffect(.degrees(90))
                            Spacer()
                            Text("or sign in with")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Divider()
                                .rotationEffect(.degrees(90))
                            Spacer()
                        }

                        ButtonView(title: "Continue with Google", style: .secondary, action: {
                            print("Secondary button tapped")
                        }, leadingIcon: ImageResource.google)
                        
                        Button {
                            
                        } label: {
                            Text("Create an account")
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
}

#Preview {
    LoginScreenView()
}
