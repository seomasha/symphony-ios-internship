//
//  DottedLine.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 6. 9. 2024..
//

import SwiftUI

struct DottedLine: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let dashWidth: CGFloat = 4
                let dashSpacing: CGFloat = 4
                var currentX: CGFloat = 0
                
                while currentX < width {
                    path.move(to: CGPoint(x: currentX, y: 0))
                    path.addLine(to: CGPoint(x: currentX + dashWidth, y: 0))
                    currentX += dashWidth + dashSpacing
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round))
            .foregroundColor(Color(.systemGray4))
        }
        .frame(height: 1)
    }
}

#Preview {
    DottedLine()
}
