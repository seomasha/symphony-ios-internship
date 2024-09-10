//
//  BottomBarNavigation.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct BottomBarNavigation: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel
    @State private var selectedTab = 0
    
    init(userViewModel: UserViewModel, flightViewModel: FlightViewModel, initialTab: Int = 0) {
        self.userViewModel = userViewModel
        self.flightViewModel = flightViewModel
        self._selectedTab = State(initialValue: initialTab)
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeScreenView(userViewModel: userViewModel,
                               flightViewModel: FlightViewModel())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
                
                MyFlightsScreen(userViewModel: userViewModel, flightViewModel: flightViewModel)
                    .tabItem {
                        Image(systemName: "airplane.circle")
                        Text("My flights")
                    }
                    .tag(1)
                
                OffersScreen()
                    .tabItem {
                        Image(systemName: "party.popper")
                        Text("Offers")
                    }
                    .tag(2)
                
                MyProfileScreenView(userViewModel: userViewModel, flightViewModel: flightViewModel)
                    .tabItem {
                        Image(systemName: "person")
                        Text("My profile")
                    }
                    .tag(3)
            }
            .toolbarBackground(.white, for: .tabBar)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    BottomBarNavigation(userViewModel: UserViewModel(), 
                        flightViewModel: FlightViewModel())
}
