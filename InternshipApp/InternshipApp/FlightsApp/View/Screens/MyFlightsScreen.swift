//
//  MyFlightsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI

struct MyFlightsScreen: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @State private var isLoading: Bool = true // State variable to track loading

    var body: some View {
        NavigationStack {
            Text("Booked flights")
                .font(.title)
                .foregroundStyle(.blue)
            
            if isLoading {
                ProgressView("Loading booked flights...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .padding()
            } else {
                ScrollView {
                    ForEach(userViewModel.bookedFlights, id: \.id) { flight in
                        VStack {
                            Text(flight.airCompany)
                            Text(flight.arrivalCode)
                            Text(flight.departureCode)
                            Text("\(flight.price)")
                            Text("\(flight.date)")
                        }
                        .padding()
                    }
                }
            }
            Spacer()
        }
        .onAppear {
            Task {
                do {
                    try await userViewModel.fetchBookedFlights()
                    isLoading = false
                } catch {
                    print("Failed to load booked flights: \(error.localizedDescription)")
                    isLoading = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyFlightsScreen(userViewModel: UserViewModel())
}
