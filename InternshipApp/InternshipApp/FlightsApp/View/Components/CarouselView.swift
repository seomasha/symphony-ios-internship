//
//  CarousselView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct CarouselView: View {
    let items = ["item1", "item2", "item3", "item4", "item5"]
    
    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(items, id: \.self) { item in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.blue)
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.2)
                            .shadow(radius: 5)
                        
                        Text(item)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    CarouselView()
}
