//
//  NumberStepperInput.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 26. 8. 2024..
//

import SwiftUI

struct NumberPickerInput: View {
    var label: String
    @Binding var value: Int
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
                Picker(selection: $value, label: Text("")) {
                    ForEach(0...100, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal, 48)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
        }
    }
}

#Preview {
    NumberPickerInput(label: "Choose a number", value: .constant(0))
}
