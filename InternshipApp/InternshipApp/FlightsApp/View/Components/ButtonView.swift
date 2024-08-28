//
//  ButtonView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var style: ButtonStyle
    var action: () -> Void
    var leadingIcon: ImageResource?
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let iconName = leadingIcon {
                    Image(iconName)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Text(title)
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(style == .primary ? .white : .black)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(style == .primary ? Color.blue : Color(.googlegray))
            .cornerRadius(8)

        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ButtonView(title: "Primary Button", style: .primary, action: {
            print("Primary button tapped")
        })

        ButtonView(title: "Secondary Button", style: .secondary, action: {
            print("Secondary button tapped")
        }, leadingIcon: ImageResource.google)
    }
    .padding()
}
