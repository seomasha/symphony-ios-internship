//
//  PasswordTextField.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct PasswordTextField: View {
    
    @Binding var text: String
    
    @State private var isSecure: Bool = true
    
    var body: some View {
        HStack {
            Text("Your password")
                .fontWeight(.semibold)
            Spacer()
        }
        HStack {
            if isSecure {
                SecureField("Enter your password", text: $text)
                    .padding(.leading, 8)
                    .foregroundStyle(.secondary)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            } else {
                TextField("Enter your password", text: $text)
                    .padding(.leading, 8)
                    .foregroundStyle(.secondary)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            
            Button(action: {
                isSecure.toggle()
            }) {
                Image(systemName: isSecure ? "eye" : "eye.slash")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    PasswordTextField(text: .constant(""))
}
