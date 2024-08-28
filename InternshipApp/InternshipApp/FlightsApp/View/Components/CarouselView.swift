//
//  CarousselView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct CarouselView: View {
    
    var body: some View {
        GeometryReader { geometry in
            TabView {
                ForEach(CarouselList().items, id: \.id) { item in
                    CarouselItem(percentage: item.percentage,
                                 name: item.name,
                                 image: item.image,
                                 color: item.color)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    CarouselView()
}
