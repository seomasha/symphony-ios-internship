//
//  BookedFlight.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI

struct BookedFlight: View {

    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel
    var flight: BookedFlightModel

    var body: some View {
        NavigationLink {
            FlightDetailsScreen(userViewModel: userViewModel, flightViewModel: flightViewModel)
        } label: {
            VStack(alignment: .leading) {
                Text("\(flight.airCompany) (\(flight.departureCode) -> \(flight.arrivalCode))")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Text("\(userViewModel.formatDate(flight.date))")
                        .fontWeight(.light)
                    
                    Spacer()
                    Text("$\(flight.price)")
                        .font(.title)
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color(.systemGray4), lineWidth: 1.0)
            )
            .padding()
            .foregroundStyle(.black)
        }
        .simultaneousGesture(TapGesture().onEnded {
            userViewModel.selectedBookedFlight = flight
        })
    }
}

#Preview {
    BookedFlight(userViewModel: UserViewModel(),
                 flightViewModel: FlightViewModel(),
                 flight: BookedFlightModel(price: 500,
                                           date: Date(),
                                           departureCode: "SJJ",
                                           arrivalCode: "LGA",
                                           departureTown: "Sarajevo",
                                           arrivalTown: "New York",
                                           departureLatitude: 0.0,
                                           departureLongitude: 0.0,
                                           arrivalLatitude: 0.0,
                                           arrivalLongitude: 0.0,
                                           airCompany: "Lufthansa",
                                           departureTime: "09:30",
                                           arrivalTime: "15:30"))
}
