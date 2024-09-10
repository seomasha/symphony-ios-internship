//
//  MyFlightsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI

struct MyFlightsScreen: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel

    var body: some View {
        NavigationStack {
            Text("Booked flights")
                .font(.title)
                .foregroundStyle(.blue)
            
            if userViewModel.isLoading {
                ProgressView("Loading booked flights...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            } else {
                ScrollView {
                    ForEach(userViewModel.bookedFlights, id: \.id) { flight in
                        BookedFlight(userViewModel: userViewModel,
                                     flightViewModel: flightViewModel,
                                     flight: flight)
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            
            flightViewModel.navigateToDetails = false
            
            Task {
                do {
                    try await userViewModel.fetchBookedFlights()
                    userViewModel.isLoading = false
                } catch {
                    print("Failed to load booked flights: \(error.localizedDescription)")
                    userViewModel.isLoading = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyFlightsScreen(userViewModel: UserViewModel(), flightViewModel: FlightViewModel())
}
