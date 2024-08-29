//
//  DestinationPicker.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct DestinationPicker: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    var flight: FlightModel?
    var flightOption: FlightOption
    @State private var showPopover: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(flightOption == .arrival ? "From" : "To")
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {
                Image(systemName: flightOption == .arrival ? "airplane.departure" : "airplane.arrival")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(flight?.town ?? "Select a flight")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(flight?.airportCode ?? "")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    Text(flight?.airportFullName ?? "")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding(.horizontal)
        .onTapGesture {
            showPopover = true
            flightViewModel.selectedFlightOption = flightOption
        }
        .popover(isPresented: $showPopover) {
            VStack {
                Text("Select a flight")
                    .font(.headline)
                    .padding()
                
                switch flightViewModel.selectedFlightOption {
                case .arrival:
                    ForEach(flightViewModel.flights, id: \.airportCode) { flight in
                        Button(action: {
                            flightViewModel.selectedFlight = flight
                            flightViewModel.showPopover = false
                        }) {
                            HStack {
                                Image(systemName: "airplane")
                                Text("\(flight.town) - \(flight.airportCode)")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                            }
                            .padding()
                        }
                    }
                case .departure:
                    ForEach(flightViewModel.availableDepartureFlights, id: \.airportCode) { flight in
                        Button(action: {
                            flightViewModel.selectedDepartureFlight = flight
                            flightViewModel.showPopover = false
                        }) {
                            HStack {
                                Image(systemName: "airplane")
                                Text("\(flight.town) - \(flight.airportCode)")
                                    .font(.title2)
                                    .foregroundStyle(.black)
                            }
                            .padding()
                        }
                    }
                }
            }
            .presentationCompactAdaptation(.popover)
        }
    }
}
#Preview {
    VStack {
        DestinationPicker(flightViewModel: FlightViewModel(), flight: nil, flightOption: .arrival)
        DestinationPicker(flightViewModel: FlightViewModel(), flight: nil, flightOption: .departure)
    }
}
