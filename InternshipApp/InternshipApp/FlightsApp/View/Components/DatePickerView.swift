//
//  DatePicker.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct DatePickerView: View {
    @Binding var selectedDate: Date
    var title: String
    @State private var showDatePicker = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.gray)
                
                VStack(alignment: .leading) {
                    Text(formatDate(selectedDate))
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
            showDatePicker = true
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .labelsHidden()
                Button("Done") {
                    showDatePicker = false
                }
                .padding()
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    VStack {
        Spacer()
        DatePickerView(selectedDate: .constant(Date()), title: "Departure Date")
        Spacer()
        DatePickerView(selectedDate: .constant(Date()), title: "Return Date")
        Spacer()
    }
}
