//
//  TravellersPickerView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct TravellersPickerView: View {
    @Binding var selectedAdults: String
    @Binding var selectedChildren: String
    var title: String
    @State private var showPicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("A: \(selectedAdults)")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("C: \(selectedChildren)")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
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
                HStack {
                    VStack {
                        Text("Adults")
                        Picker("Adults", selection: $selectedAdults) {
                            ForEach(0...10, id: \.self) { i in
                                Text("\(i)").tag("\(i)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    VStack {
                        Text("Children")
                        Picker("Children", selection: $selectedChildren) {
                            ForEach(0...10, id: \.self) { i in
                                Text("\(i)").tag("\(i)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                Button("Done") {
                    showPicker = false
                }
                .padding()
            }
        }
    }
}

#Preview {
    TravellersPickerView(selectedAdults: .constant("1"), selectedChildren: .constant("0"), title: "Select Travelers")
}
