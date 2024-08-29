//
//  PickerView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct ClassPickerView: View {
    @Binding var selectedOption: String
    var title: String
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
        .popover(isPresented: $showPicker, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
            VStack {
                Picker(title, selection: $selectedOption) {
                    Text("Economy").tag("Economy")
                    Text("First Class").tag("First Class")
                    Text("Business").tag("Business")
                }
                .pickerStyle(.inline)
                
                .padding()
            }.presentationCompactAdaptation(.popover)
        }
    }
}

#Preview {
    ClassPickerView(selectedOption: .constant("Economy"), title: "Select Class")
}
