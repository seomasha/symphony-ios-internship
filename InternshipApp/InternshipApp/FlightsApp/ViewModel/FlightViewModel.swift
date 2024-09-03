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
    
    @Published var navigateToOffers = false
    @Published var navigateToHome = false
    
    @Published var selectedFlightOffer: FlightOfferModel?
    
    @Published var showFilterPopover: Bool = false
    
    @Published var minPrice: Double = 0
    @Published var maxPrice: Double = 1000
    @Published var minDate: Date = Date()
    @Published var maxDate: Date = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    @Published var minDuration: Double = 0
    @Published var maxDuration: Double = 24
    
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
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
        return FlightList().flights.filter { flight in
            arrivalFlight.possibleAirports.contains(flight.airportCode)
        }
    }
    
    func getFlightOffers() -> [FlightOfferModel] {
        guard let selectedFlight = selectedFlight,
              let selectedDepartureFlight = selectedDepartureFlight else {
            return []
        }
        
        return FlightList().flightOffers.filter { offer in
            let priceMatch = offer.price >= Int(minPrice) && offer.price <= Int(maxPrice)
            let dateMatch = offer.date >= minDate && offer.date <= maxDate
            let durationMatch = convertDurationToHours(offer.flightDuration) >= minDuration &&
            convertDurationToHours(offer.flightDuration) <= maxDuration
            let departureDateMatch = Calendar.current.isDate(offer.date, inSameDayAs: departureDate)
            
            return priceMatch && dateMatch && durationMatch && departureDateMatch &&
            ((offer.departureCode == selectedDepartureFlight.airportCode &&
              offer.arrivalCode == selectedFlight.airportCode) ||
             (offer.departureCode == selectedFlight.airportCode &&
              offer.arrivalCode == selectedDepartureFlight.airportCode))
        }
    }
    
    private func convertDurationToHours(_ duration: String) -> Double {
        let components = duration.split(separator: ":").map { Double($0) ?? 0 }
        return components[0] + components[1] / 60
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
    
    func validateFlightSelection() -> Bool {
        if selectedFlight == nil || selectedDepartureFlight == nil {
            alertMessage = "Please select both a departure and arrival flight."
            showAlert = true
            return false
        }
        return true
    }
}
