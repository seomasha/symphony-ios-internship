//
//  OffersScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 10. 9. 2024..
//

import SwiftUI
import CoreLocation

struct OffersScreen: View {
    @ObservedObject private var locationManager: LocationManager
    @ObservedObject var flightViewModel: FlightViewModel

    init() {
        locationManager = LocationManager()
        flightViewModel = FlightViewModel()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if locationManager.isLocationGranted, let currentLocation = locationManager.currentLocation {
                    Text("Nearest Airports:")
                        .font(.largeTitle)
                        .padding()

                    ScrollView {
                        ForEach(flightViewModel.nearestAirports, id: \.airportCode) { airport in
                            ForEach(flightViewModel.closestAirportOffers, id: \.id) { offer in
                                AirportView(airport: airport,
                                            offer: offer,
                                            flightViewModel: flightViewModel)
                            }
                        }
                    }
                    .onAppear {
                        flightViewModel.findNearestAirports(currentLocation: currentLocation)
                    }
                } else {
                    Text("Location permission is denied.")
                        .padding()

                    Text("Please enable location services in Settings.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
            }
            .padding()
        }
    }
}

#Preview {
    OffersScreen()
}
