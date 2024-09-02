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
    
    @Published var flights: [FlightModel] = [
        FlightModel(town: "Mostar", 
                    airportCode: "MST",
                    airportFullName: "Mostar International Airport",
                    possibleAirports: ["MUC", "IST"]),
        
        FlightModel(town: "Sarajevo",
                    airportCode: "SJJ",
                    airportFullName: "Sarajevo International Airport",
                    possibleAirports: ["LGA", "IST"]),
        
        FlightModel(town: "New York", 
                    airportCode: "LGA",
                    airportFullName: "LaGuardia Airport",
                    possibleAirports: ["SJJ", "MST", "ZRH", "LOS", "FCO", "MUC"]),
        
        FlightModel(town: "Istanbul", 
                    airportCode: "IST",
                    airportFullName: "Istanbul Airport",
                    possibleAirports: ["SJJ", "MST"]),
        
        FlightModel(town: "Munchen", 
                    airportCode: "MUC",
                    airportFullName: "Munich International Airport",
                    possibleAirports: ["LGA", "IST", "SJJ", "MST"]),
        
        FlightModel(town: "Zurich", 
                    airportCode: "ZRH",
                    airportFullName: "Zurich Airport",
                    possibleAirports: ["SJJ", "LGA", "MUC"]),
        
        FlightModel(town: "Lagos",
                    airportCode: "LOS",
                    airportFullName: "Murtala Muhammed International Airport",
                    possibleAirports: ["ZRH"]),
        
        FlightModel(town: "Rome", 
                    airportCode: "FCO",
                    airportFullName: "Leonardo da Vinci–Fiumicino Airport",
                    possibleAirports: ["MUC", "LGA", "ZRH", "SJJ"])
    ]
    
    @Published var flightOffers: [FlightOfferModel] = [
        FlightOfferModel(departureCode: "MST", 
                         departureTown: "Mostar",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "12:45",
                         time: "09:30 AM",
                         date: Date(),
                         airCompany: "Qatar Airways",
                         price: 250),
        
        FlightOfferModel(departureCode: "MST",
                         departureTown: "Mostar",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "12:45",
                         time: "09:30 AM",
                         date: Date(),
                         airCompany: "Ryanair",
                         price: 135),
        
        FlightOfferModel(departureCode: "SJJ",
                             departureTown: "Sarajevo",
                             arrivalCode: "IST",
                             arrivalTown: "Istanbul",
                             flightDuration: "2:15",
                             time: "01:20 PM",
                             date: Date(),
                             airCompany: "Turkish Airlines",
                             price: 190),
            
            FlightOfferModel(departureCode: "MUC",
                             departureTown: "Munchen",
                             arrivalCode: "SJJ",
                             arrivalTown: "Sarajevo",
                             flightDuration: "1:50",
                             time: "10:00 AM",
                             date: Date(),
                             airCompany: "Lufthansa",
                             price: 220),
                             
            FlightOfferModel(departureCode: "LGA",
                             departureTown: "New York",
                             arrivalCode: "ZRH",
                             arrivalTown: "Zurich",
                             flightDuration: "8:30",
                             time: "07:00 AM",
                             date: Date(),
                             airCompany: "Swiss Air",
                             price: 450),
                             
            FlightOfferModel(departureCode: "FCO",
                             departureTown: "Rome",
                             arrivalCode: "LGA",
                             arrivalTown: "New York",
                             flightDuration: "9:15",
                             time: "11:00 AM",
                             date: Date(),
                             airCompany: "Alitalia",
                             price: 380)
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
    
    func getFlightOffers() -> [FlightOfferModel] {
        guard let selectedFlight = selectedFlight,
              let selectedDepartureFlight = selectedDepartureFlight else {
            return []
        }
        
        return flightOffers.filter { offer in
            (offer.departureCode == selectedDepartureFlight.airportCode &&
             offer.arrivalCode == selectedFlight.airportCode) ||
            (offer.departureCode == selectedFlight.airportCode &&
             offer.arrivalCode == selectedDepartureFlight.airportCode)
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
