//
//  DestinationPicker.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 29. 8. 2024..
//

import SwiftUI

struct DestinationPicker: View {
    
    var flightOption: FlightOption
    var town: String
    var airportCode: String
    var airportFullName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(flightOption == .arrival ? "From" : "To")
                .font(.caption)
                .foregroundStyle(.gray)
            HStack {
                switch flightOption {
                case .arrival:
                    Image(systemName: "airplane.departure")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(town)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text(airportCode)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .fontWeight(.light)
                        }
                        Text(airportFullName)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    
                case .departure:
                    Image(systemName: "airplane.arrival")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(town)
                                .font(.title3)
                                .fontWeight(.bold)
                            
                            Text(airportCode)
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .fontWeight(.light)
                        }
                        Text(airportFullName)
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
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
    }
}

#Preview {
    VStack {
        Spacer()
        DestinationPicker(flightOption: .arrival,
                          town: "Mostar",
                          airportCode: "MST",
                          airportFullName: "Mostar International Airport")
        Spacer()
        DestinationPicker(flightOption: .departure,
                          town: "New York",
                          airportCode: "LGA",
                          airportFullName: "Subhash Chandra International Airport")
        Spacer()
    }
}
