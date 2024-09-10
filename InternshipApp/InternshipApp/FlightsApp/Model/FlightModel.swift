//
//  FlightModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import Foundation

struct FlightModel: Identifiable {
    let id = UUID()
    let town: String
    let airportCode: String
    let airportFullName: String
    let possibleAirports: [String]
    let latitude: Double
    let longitude: Double
    let url: String
}
