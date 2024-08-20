//
//  Break.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct Break: View {
    
    var label: String
    
    var body: some View {
        HStack {
            Spacer()
            Divider()
                .rotationEffect(.degrees(90))
            Spacer()
            Text(label)
                .foregroundStyle(.secondary)
            Spacer()
            Divider()
                .rotationEffect(.degrees(90))
            Spacer()
        }
    }
}

#Preview {
    Break(label: "or sign in with")
}
