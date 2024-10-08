//
//  FlightSelectionScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct FlightSelectionScreen: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image(ImageResource.background)
                        .resizable()
                        .frame(maxWidth: 450, maxHeight: 350)
                        .overlay(
                            .blue.opacity(0.6)
                        )
                        .blendMode(.plusDarker)
                        .ignoresSafeArea()
                    
                    VStack {
                        HStack {
                            Spacer()
                            VStack {
                                Text(flightViewModel.selectedFlightOffer?.arrivalCode ?? "")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text(flightViewModel.selectedFlightOffer?.arrivalTown ?? "")
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Image(systemName: "airplane.departure")
                                    .padding()
                                    .foregroundStyle(.white)
                                    .background(
                                        Color(.lightblue)
                                    )
                                    .clipShape(Circle())
                                    .padding()
                                Text("\(flightViewModel.selectedFlightOffer?.flightDuration ?? "N/A") hours")
                                    .foregroundStyle(.white)
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text(flightViewModel.selectedFlightOffer?.departureCode ?? "")
                                    .foregroundStyle(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                                Text(flightViewModel.selectedFlightOffer?.departureTown ?? "")
                                    .foregroundStyle(.white)
                            }
                            Spacer()
                        }
                        
                        VStack {
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
                                            Text(flightViewModel.selectedFlightOffer?.time ?? "")
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
                                            Text(flightViewModel.formatDate(flightViewModel.selectedFlightOffer?.date ?? Date()))
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
                            Divider()
                            HStack {
                                Image(systemName: "airplane.departure")
                                Text(flightViewModel.selectedFlightOffer?.airCompany ?? "")
                                    .font(.title2)
                                    .fontWeight(.light)
                                
                                Spacer()
                                
                                Text("$\(flightViewModel.selectedFlightOffer?.price ?? 0)")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.lightblue))
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Promo code")
                                        .font(.caption)
                                        .foregroundStyle(.gray)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("****")
                                                .font(.caption)
                                                .foregroundStyle(Color(.lightGray))
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(.systemGray4), lineWidth: 1)
                                )
                                .padding(.horizontal)
                                
                                ButtonView(title: "Book flight", style: .primary) {
                                    if flightViewModel.validateFlightBooking() {
                                        Task {
                                            do {
                                                try await userViewModel.addFlight(flightViewModel: flightViewModel)
                                            } catch {
                                                print(error)
                                            }
                                        }
                                        
                                        flightViewModel.navigateToConfirmation = true
                                        flightViewModel.navigateToSelection = false
                                    } else {
                                        flightViewModel.showAlert = true
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            flightViewModel.navigateToOffers = true
                            flightViewModel.navigateToSelection = false
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
            ScrollView {
                VStack(spacing: 24) {
                    SelectionOption(icon: "person.text.rectangle",
                                    title: "Personal details",
                                    subtitle: "Update your passenger details",
                                    incomplete: flightViewModel.validatePersonalDetails(),
                                    screen: AnyView(PersonalDetailsScreen(flightViewModel: flightViewModel)))
                    
                    SelectionOption(icon: "person.crop.square",
                                    title: "Check in",
                                    subtitle: "You can check in now",
                                    incomplete: flightViewModel.validateOnlineCheckIn(),
                                    screen: AnyView(OnlineCheckInScreen(flightViewModel: flightViewModel)),
                                    option: Selection.checkIn)
                    
                    SelectionOption(icon: "airplane",
                                    title: "Upgrade flight",
                                    subtitle: "Upgrade your flight seat",
                                    incomplete: false)
                    
                    SelectionOption(icon: "chair",
                                    title: "Choose seat",
                                    subtitle: "Choose your seat",
                                    incomplete: flightViewModel.selectedSeat == nil,
                                    screen: AnyView(ChooseSeatScreen(flightViewModel: flightViewModel)))
                    
                    SelectionOption(icon: "suitcase",
                                    title: "Baggage allowance",
                                    subtitle: "40kg checked baggage",
                                    incomplete: false)
                    
                    SelectionOption(icon: "plus.rectangle.on.rectangle",
                                    title: "Purchase additional baggage",
                                    subtitle: "Upgrade your baggage",
                                    incomplete: false)
                    
                    ButtonView(title: "Book Flight", style: .primary) {
                        if flightViewModel.validateFlightBooking() {
                            Task {
                                do {
                                    try await userViewModel.addFlight(flightViewModel: flightViewModel)
                                } catch {
                                    print(error)
                                }
                            }
                            
                            flightViewModel.navigateToConfirmation = true
                            flightViewModel.navigateToSelection = false
                        } else {
                            flightViewModel.showAlert = true
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $flightViewModel.navigateToOffers) {
            FlightOffersScreen(flightViewModel: flightViewModel,
                               userViewModel: userViewModel)
        }
        .navigationDestination(isPresented: $flightViewModel.navigateToConfirmation) {
            FlightConfirmationScreenView(flightViewModel: flightViewModel,
                                         userViewModel: userViewModel)
        }
        .alert(isPresented: $flightViewModel.showAlert) {
            Alert(title: Text("Missing Information"),
                  message: Text(flightViewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    FlightSelectionScreen(flightViewModel: FlightViewModel(),
                          userViewModel: UserViewModel())
}
