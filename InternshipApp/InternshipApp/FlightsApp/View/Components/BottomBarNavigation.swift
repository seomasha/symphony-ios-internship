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
            TabView {
                HomeScreenView(userViewModel: userViewModel,
                               flightViewModel: FlightViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
                
                MyFlightsScreen(userViewModel: userViewModel)
                    .tabItem {
                        Image(systemName: "airplane.circle")
                        Text("My flights")
                    }
                    .tag(1)
                
                MyProfileScreenView(userViewModel: userViewModel)
                    .tabItem {
                        Image(systemName: "person")
                        Text("My profile")
                    }
                    .tag(2)
            }
            .toolbarBackground(.white, for: .tabBar)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BottomBarNavigation(userViewModel: UserViewModel())
}
