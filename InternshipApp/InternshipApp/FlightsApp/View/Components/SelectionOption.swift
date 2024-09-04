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
    var incomplete: Bool
    var screen: AnyView?
    
    @State private var navigate = false
    
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
            
            if incomplete {
                if title != "Check in" {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.red)
                } else {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundStyle(.blue)
                }

            }
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
        .onTapGesture {
            if screen != nil {
                navigate = true
            }
        }
        .background(
            NavigationLink(
                destination: screen,
                isActive: $navigate,
                label: { EmptyView() }
            )
            .hidden() // Keep the NavigationLink hidden while using the tap gesture for navigation
        )
    }
}

#Preview {
    SelectionOption(
        icon: "airplane.departure",
        title: "Personal",
        subtitle: "Subtitle",
        incomplete: true,
        screen: AnyView(Text("Personal Details Screen"))
    )
}

#Preview("Without Navigation") {
    SelectionOption(
        icon: "airplane.departure",
        title: "Personal",
        subtitle: "Subtitle",
        incomplete: true,
        screen: nil
    )
}
