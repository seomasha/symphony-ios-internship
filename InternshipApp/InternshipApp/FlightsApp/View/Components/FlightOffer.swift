//
//  FlightOffer.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 2. 9. 2024..
//

import SwiftUI

struct FlightOffer: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    @ObservedObject var userViewModel: UserViewModel
    var flightOffer: FlightOfferModel
    @Binding var selectedFlightOffer: FlightOfferModel?
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(flightOffer.departureCode)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(flightOffer.departureTown)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                
                Spacer()
                Image(systemName: "airplane.departure")
                    .padding(.all, 12)
                    .background(.blue)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                Spacer()
                
                VStack {
                    Text(flightOffer.arrivalCode)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(flightOffer.arrivalTown)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
            }
            Text("\(flightOffer.flightDuration) hours")
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Time")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(flightOffer.time)
                                .font(.caption)
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
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(flightViewModel.formatDate(flightOffer.date))
                                .font(.caption)
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
            .padding(.vertical)
            Divider()
            HStack {
                Image(systemName: "airplane.departure")
                Text(flightOffer.airCompany)
                    .font(.title2)
                    .fontWeight(.light)
                
                Spacer()
                
                Text("$\(flightOffer.price)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.lightblue))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(flightOffer == selectedFlightOffer ? .blue : Color(.systemGray4), lineWidth: flightOffer == selectedFlightOffer ? 4 : 1)
        )
        .padding()
        .onTapGesture {
            selectedFlightOffer = flightOffer
            flightViewModel.navigateToSelection = true
            flightViewModel.navigateToOffers = false
        }
        .navigationDestination(isPresented: $flightViewModel.navigateToSelection) {
            FlightSelectionScreen(flightViewModel: flightViewModel, userViewModel: userViewModel)
        }
    }
}
