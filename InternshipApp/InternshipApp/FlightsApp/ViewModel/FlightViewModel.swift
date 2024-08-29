//
//  FlightViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import Foundation

@MainActor
final class FlightViewModel: ObservableObject {
    @Published var selectedOption: String = "One way"
    @Published var departureDate: Date = Date()
    @Published var arrivalDate: Date = Date()
    @Published var selectedAdults: String = "0"
    @Published var selectedChildren: String = "0"
    @Published var selectedClass: String = "Economy"
    @Published var selectedFlightOption: FlightOption = .arrival
    
    @Published var flights: [FlightModel] = [
        FlightModel(town: "Mostar", airportCode: "MST", airportFullName: "Mostar International Airport", possibleAirports: ["LGA", "IST"]),
        FlightModel(town: "Sarajevo", airportCode: "SJJ", airportFullName: "Sarajevo International Airport", possibleAirports: ["LGA", "IST"]),
        FlightModel(town: "New York", airportCode: "LGA", airportFullName: "LaGuardia Airport", possibleAirports: ["SJJ", "MST"]),
        FlightModel(town: "Istanbul", airportCode: "IST", airportFullName: "Istanbul Airport", possibleAirports: ["SJJ", "MST"])
    ]
    
    @Published var selectedFlight: FlightModel?
    @Published var selectedDepartureFlight: FlightModel?
    
    var availableDepartureFlights: [FlightModel] {
        guard let arrivalFlight = selectedFlight else {
            return []
        }
        return flights.filter { flight in
            arrivalFlight.possibleAirports.contains(flight.airportCode)
        }
    }
    
    func changeFlights() {
        let temp = selectedFlight
        selectedFlight = selectedDepartureFlight
        selectedDepartureFlight = temp
    }

    func validateReturnDate() -> Bool {
        return selectedOption == "One way"
    }
}
