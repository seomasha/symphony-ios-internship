//
//  BookedFlightModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import Foundation

struct BookedFlightModel: Identifiable {
    let id = UUID() // change this to string bookedflightID
    
    let price: Int
    let date: Date
    let departureCode: String
    let arrivalCode: String
    let airCompany: String
}
