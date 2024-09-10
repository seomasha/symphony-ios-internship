//
//  AirportView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 10. 9. 2024..
//

import SwiftUI

struct AirportView: View {
    let airport: FlightModel
    let offer: FlightOfferModel
    @ObservedObject var flightViewModel: FlightViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: airport.url)) { image in
                image
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                HStack {
                    Text("\(offer.departureCode) -> \(offer.arrivalCode)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .multilineTextAlignment(.leading)
                        .shadow(radius: 10)
                    
                    Spacer()
                    
                    Text("$\(offer.price)")
                        .font(.title)
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .padding()
                }
                
                Text("\(flightViewModel.formatDate(offer.date))")
                    .font(.title)
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .padding()
                
                Text(airport.airportFullName)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 10)
            }
        }
        .padding()
    }
}

#Preview {
    AirportView(airport: FlightModel(town: "Munchen", airportCode: "MUC", airportFullName: "Munich International Airport", possibleAirports: ["LGA", "IST", "SJJ", "MST"], latitude: 48.3540, longitude: 11.7884, url: "https://lh3.googleusercontent.com/p/AF1QipOvNpjnSbLyBGlG9Xzp4m4K-pjh-hy3ihWwNTYG=s1360-w1360-h1020"), offer: FlightOfferModel(departureCode: "LGA", departureTown: "New York", arrivalCode: "SJJ", arrivalTown: "Sarajevo", flightDuration: "08:30", time: "09:00", date: Date(), airCompany: "Turkish Airlines", price: 300), flightViewModel: FlightViewModel())
}
