//
//  CardRow.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct CardRow: View {
    
    var icon: String
    var title: String
    var subtitle: String
    var warning: String = ""
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding()
                    .background(.bar)
                    .foregroundColor(.blue)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 15) {
                    Text(title)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                    
                    Text(subtitle)
                        .font(.system(size: 12))
                        .fontWeight(.light)
                }.padding(.horizontal)
                
                Spacer()
                
                Image(systemName: warning)
                    .foregroundStyle(.red)
                
                Image(systemName: "greaterthan")
                    .foregroundStyle(.gray)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CardRow(icon: "person",
            title: "My account",
            subtitle: "Make changes to your account") {
        print("Test")
    }
}
