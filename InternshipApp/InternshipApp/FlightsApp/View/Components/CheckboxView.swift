//
//  CheckboxView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct CheckboxView: View {
    @State private var isChecked: Bool = false
    var label: String
    
    var body: some View {
        Toggle(isOn: $isChecked) {
            Text(label)
                .font(.system(size: 16, weight: .light))
        }
        .toggleStyle(CheckboxToggleStyle())
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.blue)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            configuration.label
        }
    }
}

#Preview {
    CheckboxView(label: "Keep me signed in")
}
