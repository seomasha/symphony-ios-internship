//
//  Cja.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import SwiftUI

struct ChangePassView: View {
    
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
                            
                            Text("Change password")
                                .foregroundStyle(.white)
                                .font(.headline)
                                .padding(.vertical)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.clear)
                                    .padding(.horizontal)
                            }
                            .frame(width: 44) // For centering the "Change password"
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .ignoresSafeArea(edges: .top)
                    
                    PasswordTextField(text: $userViewModel.newPassword)
                        .padding(.horizontal)
                    
                    if userViewModel.matchingPass() {
                        Text("The password you have entered can't be the same as the previous!")
                            .foregroundStyle(.red)
                            .padding(.horizontal)
                    }
                    
                    ButtonView(title: "Change", style: .primary) {
                        Task {
                            do {
                                try await userViewModel.changePassword(pass: userViewModel.newPassword)
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ChangePassView(userViewModel: UserViewModel())
}
