//
//  HomeScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 20. 8. 2024..
//

import SwiftUI

struct HomeScreenView: View {
    var body: some View {
        NavigationStack {
            Text("Signed in!")
            Button("Log out") {
                Task {
                    do {
                        try AuthenticationManager.shared.signOut()
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreenView()
}
