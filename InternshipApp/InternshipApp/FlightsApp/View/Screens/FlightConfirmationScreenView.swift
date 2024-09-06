//
//  FlightConfirmationScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 6. 9. 2024..
//

import SwiftUI

struct FlightConfirmationScreenView: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 32) {
                    HStack {
                        Image(systemName: "airplane.departure")
                            .foregroundStyle(.blue)
                        Text(flightViewModel.selectedFlightOffer?.airCompany ?? "Air Company")
                            .font(.title3)
                            .fontWeight(.light)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(flightViewModel.formatDate(flightViewModel.selectedFlightOffer?.date ?? Date()))")
                                .font(.title3)
                                .fontWeight(.light)
                            
                            Text("09:30AM")
                                .font(.subheadline)
                                .fontWeight(.light)
                        }
                    }
                    
                    HStack {
                        VStack {
                            Text("09:30 AM")
                                .fontWeight(.bold)
                            
                            Text(flightViewModel.selectedFlightOffer?.departureCode ?? "MST")
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "airplane.departure")
                                .resizable()
                                .foregroundStyle(.blue)
                                .frame(width: 30, height: 30)
                            
                            Text(flightViewModel.selectedFlightOffer?.flightDuration ?? "10h30m")
                                .font(.caption)
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("09:30 AM")
                                .fontWeight(.bold)
                            
                            Text(flightViewModel.selectedFlightOffer?.arrivalCode ?? "LGA")
                                .fontWeight(.light)
                        }
                    }
                    
                    Divider()
                    
                    HStack(spacing: 36) {
                        VStack {
                            Text(flightViewModel.selectedClass)
                                .fontWeight(.light)
                            
                            Text("Class")
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            Text("\(Int.random(in: 1...10))")
                                .fontWeight(.light)
                            
                            Text("Gate")
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            Text("\(Int.random(in: 1...10))")
                                .fontWeight(.light)
                            
                            Text("Terminal")
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                        
                        VStack {
                            Text(flightViewModel.generateRandomCombination())
                                .fontWeight(.light)
                            
                            Text("Flight")
                                .font(.caption2)
                                .fontWeight(.bold)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(ImageResource.airplaneIcon)
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text(userViewModel.user?.name ?? "Placeholder")
                                .fontWeight(.bold)
                            
                            Text("\(userViewModel.user?.age ?? 0) years")
                                .fontWeight(.light)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chair.lounge.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.blue)
                        
                        Text(flightViewModel.selectedSeat?.seatNo ?? "00A")
                            .fontWeight(.light)
                    }
                    
                    DottedLine()
                    
                    Image(systemName: "qrcode")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                .padding()
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                        .shadow(radius: 1)
                )
                .padding()
                
                ButtonView(title: "Print ticket", style: .primary) {
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        flightViewModel.navigateToHome = true
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $flightViewModel.navigateToHome) {
            HomeScreenView(userViewModel: userViewModel, flightViewModel: flightViewModel)
        }
    }
}

#Preview {
    FlightConfirmationScreenView(flightViewModel: FlightViewModel(), userViewModel: UserViewModel())
}
