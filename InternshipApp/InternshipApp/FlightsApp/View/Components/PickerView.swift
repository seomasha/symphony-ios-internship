//
//  PickerView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

import SwiftUI

struct PickerView: View {
    @Binding var selectedOption: String
    var title: String
    var options: [String]
    @State private var showPicker = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {                
                VStack(alignment: .leading) {
                    Text(selectedOption)
                        .font(.caption)
                        .fontWeight(.bold)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
        .onTapGesture {
            showPicker = true
        }
        .sheet(isPresented: $showPicker) {
            VStack {
                Picker(title, selection: $selectedOption) {
                    ForEach(options, id: \.self) { option in
                        Text(option).tag(option)
                    }
                }
                .pickerStyle(.inline)
                
                Button("Done") {
                    showPicker = false
                }
                .padding()
            }
        }
    }
}

#Preview {
    VStack {
        Spacer()
        PickerView(selectedOption: .constant("Option 1"),
                          title: "Select Option",
                          options: ["Option 1", "Option 2", "Option 3"])
        Spacer()
        PickerView(selectedOption: .constant("Option 2"),
                          title: "Select Option",
                          options: ["Option 1", "Option 2", "Option 3"])
        Spacer()
    }
}
