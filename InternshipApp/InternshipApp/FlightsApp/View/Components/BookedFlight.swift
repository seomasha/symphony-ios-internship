//
//  BookedFlight.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI

struct BookedFlight: View {
    
    @ObservedObject var userViewModel: UserViewModel
    var flight: BookedFlightModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(flight.airCompany) (\(flight.departureCode) -> \(flight.arrivalCode))")
                .font(.title2)
                .fontWeight(.bold)
            
            HStack {
                Text("\(userViewModel.formatDate(flight.date))")
                    .fontWeight(.light)
                
                Spacer()
                Text("$\(flight.price)")
                    .font(.title)
                    .foregroundStyle(.blue)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 1.0)
        )
        .padding()
    }
}

#Preview {
    BookedFlight(userViewModel: UserViewModel(),
                 flight: BookedFlightModel(price: 500,
                                           date: Date(),
                                           departureCode: "SJJ",
                                           arrivalCode: "LGA",
                                           airCompany: "Lufthansa"))
}
