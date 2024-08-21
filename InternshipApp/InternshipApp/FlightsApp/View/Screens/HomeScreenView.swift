//
//  HomeScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 20. 8. 2024..
//

import SwiftUI

struct HomeScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            Text("Welcome to Home screen")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreenView(userViewModel: UserViewModel())
}
