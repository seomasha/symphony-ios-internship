//
//  Card.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct Card: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Account")
                .font(.headline)
                .padding(.horizontal)
            
            VStack {
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account")
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account")
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account")
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account")
                CardRow(icon: "person",
                        title: "My account",
                        subtitle: "Make changes to your account")
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(radius: 1)
            .padding()
            
        }
    }
}

#Preview {
    Card()
}
