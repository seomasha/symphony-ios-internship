//
//  BottomBarNavigation.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct BottomBarNavigation: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            if userViewModel.isSignedIn {
                TabView {
                    HomeScreenView(userViewModel: userViewModel,
                                   flightViewModel: FlightViewModel())
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(0)
                    
                    MyProfileScreenView(userViewModel: userViewModel)
                        .tabItem {
                            Image(systemName: "person")
                            Text("My profile")
                        }
                        .tag(1)
                }
                .toolbarBackground(.white, for: .tabBar)
            } else {
                LoginScreenView(userViewModel: userViewModel)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BottomBarNavigation(userViewModel: UserViewModel())
}
