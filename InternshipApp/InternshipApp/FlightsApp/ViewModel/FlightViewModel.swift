//
//  FlightViewModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import Foundation
import _PhotosUI_SwiftUI
import SwiftUI
import CoreImage.CIFilterBuiltins

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
    @Published var navigateToSelection = false
    @Published var navigateToConfirmation = false
    @Published var navigateToDetails = false
    
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
    
    @Published var rows = ["A", "B", "C", "D", "E", "F"]
    @Published var seatNumbers = 1...10
    
    @Published var seatColumns: [GridItem] = [GridItem(.flexible()),
                                              GridItem(.flexible()),
                                              GridItem(.flexible()),
                                              GridItem(.flexible()),
                                              GridItem(.flexible()),
                                              GridItem(.flexible())]
    
    var seats: [Seat] {
        var seatList: [Seat] = []
        for seat in seatNumbers {
            for row in rows {
                let seatNo = "\(seat)\(row)"
                seatList.append(Seat(seatNo: seatNo))
            }
        }
        return seatList
    }
    
    //Personal details
    @Published var fullName = ""
    @Published var email = ""
    @Published var phoneNo = ""
    @Published var homeAddress = ""
    
    @Published var tempFullName = ""
    @Published var tempEmail = ""
    @Published var tempPhoneNo = ""
    @Published var tempHomeAddress = ""
    
    //Seat selection
    @Published var selectedSeat: Seat?
    
    @Published var tempSelectedSeat: Seat?
    
    //Online check in
    @Published var passportNumber = ""
    @Published var nationality = ""
    @Published var expiryDate = ""
    @Published var placeOfBirth = ""
    
    @Published var tempPassportNumber = ""
    @Published var tempNationality = ""
    @Published var tempExpiryDate = ""
    @Published var tempPlaceOfBirth = ""
    
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedImageData: Data? = nil
    
    @Published var passportImage: Data? = nil
    
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
    
    @Published var gate: Int = Int.random(in: 1...10)
    @Published var terminal: Int = Int.random(in: 1...10)
    var flightCode: String = ""
    
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
    
    func validateFlightBooking() -> Bool {
        if validatePersonalDetails() && selectedSeat == nil {
            alertMessage = "Please fill in the missing information."
            showAlert = true
            return false
        }
        return true
    }
    
    func validateFlightSelection() -> Bool {
        if selectedFlight == nil || selectedDepartureFlight == nil {
            alertMessage = "Please select both a departure and arrival flight."
            showAlert = true
            return false
        }
        return true
    }
    
    func validatePersonalDetails() -> Bool {
        return fullName.isEmpty || email.isEmpty || phoneNo.isEmpty || homeAddress.isEmpty
    }
    
    func validateOnlineCheckIn() -> Bool {
        if passportImage != nil {
            return false
        }
        
        return passportNumber.isEmpty || nationality.isEmpty || expiryDate.isEmpty || placeOfBirth.isEmpty
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
    
    func resetInfo() {
        navigateToConfirmation = true
        navigateToSelection = false
        
        tempFullName = ""
        tempEmail = ""
        tempPhoneNo = ""
        tempHomeAddress = ""
        
        fullName = ""
        email = ""
        phoneNo = ""
        homeAddress = ""
        
        tempSelectedSeat = nil
        
        selectedSeat = nil
        
        passportImage = nil
    }
    
    func savePersonalDetails() {
        fullName = tempFullName
        email = tempEmail
        phoneNo = tempPhoneNo
        homeAddress = tempHomeAddress
    }
    
    func randomLetter() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String(letters.randomElement()!)
    }
    
    func randomNumber() -> String {
        let numbers = "0123456789"
        return String(numbers.randomElement()!)
    }
    
    func generateRandomCombination() -> String {
        let randomLetters = (0..<3).map { _ in randomLetter() }.joined()
        
        let randomNumbers = (0..<3).map { _ in randomNumber() }.joined()
        
        flightCode = "\(randomLetters)\(randomNumbers)"
        return "\(randomLetters)\(randomNumbers)"
    }
    
    func calculateArrivalTime() -> String? {
        guard let selectedFlightOffer = selectedFlightOffer else {
            return nil
        }
        
        let timeComponents = selectedFlightOffer.time.split(separator: ":").map { Int($0) ?? 0 }
        guard timeComponents.count == 2 else {
            return nil
        }
        
        let calendar = Calendar.current
        let departureDate = selectedFlightOffer.date
        let departureHour = timeComponents[0]
        let departureMinute = timeComponents[1]
        
        var departureDateTime = calendar.date(bySettingHour: departureHour, minute: departureMinute, second: 0, of: departureDate)
        
        let durationComponents = selectedFlightOffer.flightDuration.split(separator: ":").map { Int($0) ?? 0 }
        guard durationComponents.count == 2 else {
            return nil
        }
        
        let durationHours = durationComponents[0]
        let durationMinutes = durationComponents[1]
        
        departureDateTime = calendar.date(byAdding: .hour, value: durationHours, to: departureDateTime ?? Date())
        departureDateTime = calendar.date(byAdding: .minute, value: durationMinutes, to: departureDateTime ?? Date())
        
        if let arrivalDateTime = departureDateTime {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm a"
            return formatter.string(from: arrivalDateTime)
        }
        
        return nil
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let cgImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
    
    func generateFlightQRCode() -> UIImage? {
        let flightDetails = """
            Air Company: \(selectedFlightOffer?.airCompany ?? "")
            Departure Code: \(selectedFlightOffer?.departureCode ?? "")
            Arrival Code: \(selectedFlightOffer?.arrivalCode ?? "")
            Time: \(selectedFlightOffer?.time ?? "")
            Date: \(formatDate(selectedFlightOffer?.date ?? Date()))
            Price: \(selectedFlightOffer?.price ?? 0)
            Selected Seat: \(selectedSeat?.seatNo ?? Seat(seatNo: "0A").seatNo)
            Flight Code: \(flightCode)
            Gate: \(gate)
            Terminal: \(terminal)
            Arrival Time: \(calculateArrivalTime() ?? "")
            """
        return generateQRCode(from: flightDetails)
    }
    
    func shareFlightInfo() {
        let flightDetails = """
            Air Company: \(selectedFlightOffer?.airCompany ?? "")
            Departure Code: \(selectedFlightOffer?.departureCode ?? "")
            Arrival Code: \(selectedFlightOffer?.arrivalCode ?? "")
            Time: \(selectedFlightOffer?.time ?? "")
            Date: \(formatDate(selectedFlightOffer?.date ?? Date()))
            Price: \(selectedFlightOffer?.price ?? 0)
            Selected Seat: \(selectedSeat?.seatNo ?? Seat(seatNo: "0A").seatNo)
            Flight Code: \(flightCode)
            Gate: \(gate)
            Terminal: \(terminal)
            Arrival Time: \(calculateArrivalTime() ?? "")
            """
        
        let activityVC = UIActivityViewController(activityItems: [flightDetails], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.present(activityVC, animated: true, completion: nil)
        }
    }
}
