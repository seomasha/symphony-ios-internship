//
//  TextFieldInput.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct TextFieldInput: View {
    
    var label: String
    var placeholder: String
    @Binding var text: String
    var iconName: String
    var secondaryText: String = ""
    
    var body: some View {
        HStack {
            Text(label)
                .fontWeight(.semibold)
            Spacer()
            Text(secondaryText)
                .font(.caption)
                .foregroundStyle(.blue)
        }
        HStack {
            TextField(placeholder, text: $text)
                .padding(.leading, 8)
                .foregroundStyle(.secondary)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            Image(systemName: iconName)
                .foregroundColor(.gray)
                .padding(.trailing, 8)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
