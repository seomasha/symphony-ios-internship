//
//  CarouselItem.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct CarouselItem: View {
    
    var percentage: Int
    var name: String
    var image: ImageResource
    var color: Color
    
    var body: some View {
        HStack {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                Text("\(percentage)% OFF")
                    .font(.headline)
                    .padding(.horizontal)
                Spacer()
            }
            .background(color.opacity(0.7))
            .frame(height: 120)
            
            VStack(alignment: .leading) {
                Text("\(percentage)% discount with \(name)")
                    .font(.headline)
                
                Text("Lorem ipsum dolor sit amet et et dip")
                    .foregroundStyle(.gray)
            }
            .frame(height: 100)
        }
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(.googlegray), lineWidth: 1)
                .padding(.horizontal, 34)
        )
    }
}

#Preview {
    CarouselItem(percentage: 20,
                 name: "Mastercard",
                 image: ImageResource.mastercard, 
                 color: .red)
}
