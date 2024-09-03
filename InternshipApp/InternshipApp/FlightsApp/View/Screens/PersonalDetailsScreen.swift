//
//  PersonalDetailsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct PersonalDetailsScreen: View {
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Personal details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack {
                    TextFieldInput(label: "Full name",
                                   placeholder: "Enter your full name",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Email address",
                                   placeholder: "Enter your email address",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Phone number",
                                   placeholder: "Enter your phone number",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Home address",
                                   placeholder: "Enter your home address",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                ButtonView(title: "Confirm", style: .primary) {
                    
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    PersonalDetailsScreen()
}
