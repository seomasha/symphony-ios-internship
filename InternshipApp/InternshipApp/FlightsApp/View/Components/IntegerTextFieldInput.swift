//
//  IntegerTextFieldInput.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 22. 8. 2024..
//

import SwiftUI

import SwiftUI

struct IntegerTextFieldInput: View {
    var label: String
    var placeholder: String
    @Binding var value: Int
    var iconName: String
    var secondaryText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(label)
                    .fontWeight(.semibold)
                Spacer()
                Text(secondaryText)
                    .font(.caption)
                    .foregroundStyle(.blue)
            }
            HStack {
                TextField(placeholder, value: $value, formatter: NumberFormatter.integerFormatter)
                    .padding(.leading, 8)
                    .foregroundStyle(.secondary)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
                
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
}

extension NumberFormatter {
    static var integerFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.allowsFloats = false
        return formatter
    }
}


#Preview {
    IntegerTextFieldInput(label: "Test", 
                          placeholder: "Test",
                          value: .constant(1),
                          iconName: "")
}
