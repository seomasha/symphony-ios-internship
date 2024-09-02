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
    @Published var showPopover: Bool = false
    
    @Published var navigateToOffers: Bool = false
    
    @Published var flights: [FlightModel] = [
        FlightModel(town: "Mostar", airportCode: "MST", airportFullName: "Mostar International Airport", possibleAirports: ["MUC", "IST"]),
        FlightModel(town: "Sarajevo", airportCode: "SJJ", airportFullName: "Sarajevo International Airport", possibleAirports: ["LGA", "IST"]),
        FlightModel(town: "New York", airportCode: "LGA", airportFullName: "LaGuardia Airport", possibleAirports: ["SJJ", "MST", "ZRH", "LOS", "FCO", "MUC"]),
        FlightModel(town: "Istanbul", airportCode: "IST", airportFullName: "Istanbul Airport", possibleAirports: ["SJJ", "MST"]),
        FlightModel(town: "Munchen", airportCode: "MUC", airportFullName: "Munich International Airport", possibleAirports: ["LGA", "IST", "SJJ", "MST"]),
        FlightModel(town: "Zurich", airportCode: "ZRH", airportFullName: "Zurich Airport", possibleAirports: ["SJJ", "LGA", "MUC"]),
        FlightModel(town: "Lagos", airportCode: "LOS", airportFullName: "Murtala Muhammed International Airport", possibleAirports: ["ZRH"]),
        FlightModel(town: "Rome", airportCode: "FCO", airportFullName: "Leonardo da Vinci–Fiumicino Airport", possibleAirports: ["MUC", "LGA", "ZRH", "SJJ"])
    ]
    
    @Published var flightOffers: [FlightOfferModel] = [
    
    ]
    
    @Published var selectedFlight: FlightModel? {
        didSet {
            selectedDepartureFlight = nil
        }
    }
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
        if selectedDepartureFlight != nil {
            let temp = selectedFlight
            selectedFlight = selectedDepartureFlight
            selectedDepartureFlight = temp
        }
    }

    func validateReturnDate() -> Bool {
        return selectedOption == "One way"
    }
}
