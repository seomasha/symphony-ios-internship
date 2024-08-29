//
//  ItemPreviewView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct ItemDetailView: View {
    var percentage: Int
    var name: String
    var image: ImageResource
    var color: Color

    var body: some View {
        NavigationView {
            VStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()

                Text("\(percentage)% OFF")
                    .font(.largeTitle)
                    .foregroundColor(color)
                    .padding()

                Text("Special offer with \(name)")
                    .font(.headline)
                    .padding()

                Spacer()
            }
            .navigationTitle("Item Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
