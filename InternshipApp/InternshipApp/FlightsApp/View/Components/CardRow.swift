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
    
    @State private var isPressed = false
    
    var body: some View {
        Button{
            action()
        } label: {
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
            .background(isPressed ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(10)
            .scaleEffect(isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: isPressed)
            
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(LongPressGesture(minimumDuration: 0.1)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false })
    }
}

#Preview {
    CardRow(icon: "person",
            title: "My account",
            subtitle: "Make changes to your account") {
        print("Test")
    }
}
