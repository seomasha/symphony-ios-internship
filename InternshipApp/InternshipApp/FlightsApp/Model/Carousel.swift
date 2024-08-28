//
//  Carousel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import Foundation
import SwiftUI

struct Carousel: Identifiable {
    let id = UUID()
    let percentage: Int
    let name: String
    let image: ImageResource
    let color: Color
}
