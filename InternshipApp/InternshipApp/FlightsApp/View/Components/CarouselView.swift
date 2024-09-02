//
//  CarousselView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct CarouselView: View {
    @State private var selectedItemID: UUID? = nil

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(CarouselList().items, id: \.id) { item in
                        CarouselItem(
                            percentage: item.percentage,
                            name: item.name,
                            image: item.image,
                            color: item.color,
                            onItemTap: {
                                withAnimation {
                                    selectedItemID = item.id
                                    proxy.scrollTo(item.id, anchor: .center)
                                }
                            }
                        )
                        .padding(.horizontal, 4)
                        .id(item.id)
                    }
                }
            }
        }
    }
}

#Preview {
    CarouselView()
}
