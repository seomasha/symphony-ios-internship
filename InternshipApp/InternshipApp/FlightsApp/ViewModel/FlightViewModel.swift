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
                         airCompany: "Ryanair",
                         price: 350),
        
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
                         price: 380),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "2:00",
                         time: "06:00 AM",
                         date: Date(),
                         airCompany: "Turkish Airlines",
                         price: 200),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "IST",
                         arrivalTown: "Istanbul",
                         flightDuration: "2:10",
                         time: "09:00 AM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 230),
        
        FlightOfferModel(departureCode: "ZRH",
                         departureTown: "Zurich",
                         arrivalCode: "SJJ",
                         arrivalTown: "Sarajevo",
                         flightDuration: "2:00",
                         time: "08:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 210),
        
        FlightOfferModel(departureCode: "ZRH",
                         departureTown: "Zurich",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "8:45",
                         time: "05:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 400),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "FCO",
                         arrivalTown: "Rome",
                         flightDuration: "9:00",
                         time: "10:00 PM",
                         date: Date(),
                         airCompany: "Alitalia",
                         price: 360),
        
        FlightOfferModel(departureCode: "LGA",
                         departureTown: "New York",
                         arrivalCode: "FCO",
                         arrivalTown: "Rome",
                         flightDuration: "9:30",
                         time: "02:00 PM",
                         date: Date(),
                         airCompany: "Delta Airlines",
                         price: 400),
        
        FlightOfferModel(departureCode: "SJJ",
                         departureTown: "Sarajevo",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "1:45",
                         time: "04:00 PM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 180),
        
        FlightOfferModel(departureCode: "FCO",
                         departureTown: "Rome",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "1:20",
                         time: "06:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 170),
        
        FlightOfferModel(departureCode: "MUC",
                         departureTown: "Munchen",
                         arrivalCode: "LGA",
                         arrivalTown: "New York",
                         flightDuration: "8:55",
                         time: "11:00 AM",
                         date: Date(),
                         airCompany: "Lufthansa",
                         price: 450),
        
        FlightOfferModel(departureCode: "LOS",
                         departureTown: "Lagos",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "7:30",
                         time: "08:00 AM",
                         date: Date(),
                         airCompany: "Swiss Air",
                         price: 500),
        
        FlightOfferModel(departureCode: "LOS",
                         departureTown: "Lagos",
                         arrivalCode: "ZRH",
                         arrivalTown: "Zurich",
                         flightDuration: "7:45",
                         time: "06:00 PM",
                         date: Date(),
                         airCompany: "Ryanair",
                         price: 470)
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
