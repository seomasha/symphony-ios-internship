//
//  HomeScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        NavigationStack {
            Text("Home screen!")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreenView()
}
