//
//  FlightOffersScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 2. 9. 2024..
//

import SwiftUI

struct FlightOffersScreen: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack(spacing: -16) {
                        
                        Button(action: {
                            flightViewModel.navigateToHome = true
                            flightViewModel.navigateToOffers = false
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                        }
                        
                        Spacer()
                        
                        Image(ImageResource.airplaneIcon)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("FLY MOSTAR")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.clear)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.blue)
                    
                    HStack {
                        VStack {
                            Text("Showing")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                            Text("\(flightViewModel.getFlightOffers().count)")
                                .foregroundStyle(.blue)
                            Text(flightViewModel.getFlightOffers().count == 1 ? "Result" : "Results")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                        }
                        .padding(.all, 8)
                        .background(
                            .blue.opacity(0.3)
                        )
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        
                        Spacer()
                        Text("Edit search preferences")
                            .foregroundStyle(.gray)
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 4)
                    .padding()
                    
                    ScrollView {
                        let offers = flightViewModel.getFlightOffers()
                        
                        if offers.isEmpty {
                            Text("No flight offers for the selected flight!")
                                .foregroundStyle(.gray)
                        } else {
                            ForEach(offers, id: \.id) { offer in
                                FlightOffer(flightOffer: offer)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationDestination(isPresented: $flightViewModel.navigateToHome) {
            HomeScreenView(userViewModel: userViewModel,
                           flightViewModel: flightViewModel)
        }
    }
}
#Preview {
    FlightOffersScreen(flightViewModel: FlightViewModel(), userViewModel: UserViewModel())
}
