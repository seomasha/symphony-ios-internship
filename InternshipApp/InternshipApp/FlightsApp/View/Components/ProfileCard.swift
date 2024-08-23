//
//  Card.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct ProfileCard: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Account")
                .font(.headline)
                .padding(.horizontal)
            
            VStack {
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account",
                        destination: AnyView(EditProfileScreenView(userViewModel: userViewModel)))
                
                CardRow(icon: "lock.circle",
                        title: "Face ID",
                        subtitle: "Enable FaceID?",
                        toggle: true)
                
                CardRow(icon: "pencil.circle",
                        title: "Change password",
                        subtitle: "Make a new password",
                        destination: AnyView(ChangePassView(userViewModel: userViewModel)))
                
                CardRow(icon: "questionmark.circle",
                        title: "FAQ",
                        subtitle: "Frequently asked questions",
                        destination: AnyView(FAQScreenView()))
                
                CardRow(icon: "rectangle.portrait.and.arrow.right",
                        title: "Sign out",
                        subtitle: "Go back to sign in") {
                    userViewModel.signOut()
                }
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 1)
            .padding()
        }
    }
}

#Preview {
    ProfileCard(userViewModel: UserViewModel())
}
