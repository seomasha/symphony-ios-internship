//
//  FlightOfferModel.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 2. 9. 2024..
//

import Foundation

struct FlightOfferModel: Identifiable, Equatable, Encodable, Hashable {
    
    let id = UUID()
    
    var departureCode: String
    var departureTown: String
    
    var arrivalCode: String
    var arrivalTown: String
    
    var flightDuration: String
    
    var time: String
    var date: Date
    
    var airCompany: String
    var price: Int
    
    var url: String
}
