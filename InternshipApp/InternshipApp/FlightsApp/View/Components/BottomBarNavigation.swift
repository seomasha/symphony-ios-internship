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
                    MyProfileScreenView(userViewModel: userViewModel)
                        .tabItem {
                            Image(systemName: "person")
                            Text("My profile")
                        }
                        .tag(0)
                }
                .toolbarBackground(.white, for: .tabBar)
            } else {
                LoginScreenView(userViewModel: userViewModel)
            }
        }
    }
}

#Preview {
    BottomBarNavigation(userViewModel: UserViewModel())
}
