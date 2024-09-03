//
//  SelectionOption.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct SelectionOption: View {
    
    var icon: String
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundStyle(.blue)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(subtitle)
                    .font(.subheadline)
                    .fontWeight(.light)
            }
            Spacer()
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#Preview {
    SelectionOption(icon: "airplane.departure", title: "Personal", subtitle: "Subtitle")
}
