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
            if userViewModel.isSignedIn {
                VStack {
                    Text("Welcome to the Home Screen!")
                        .font(.largeTitle)
                        .padding()
                    
                    Button("Log out") {
                        userViewModel.signOut()
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            } else {
                LoginScreenView(userViewModel: userViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreenView(userViewModel: UserViewModel())
}
