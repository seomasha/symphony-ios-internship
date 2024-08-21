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
        TabView {
            HomeScreenView(userViewModel: userViewModel)
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
    }
}

#Preview {
    BottomBarNavigation(userViewModel: UserViewModel())
}
