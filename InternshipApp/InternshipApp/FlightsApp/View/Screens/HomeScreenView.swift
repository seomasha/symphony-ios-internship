//
//  HomeScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct HomeScreenView: View {

    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    HStack(spacing: -16) {
                        Image(ImageResource.airplaneIcon)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("FLY MOSTAR")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.blue)

                    ScrollView {
                        VStack(spacing: 20) {
                            VStack {
                                if let user = userViewModel.user {
                                    Text("Welcome back \(user.name).")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }

                                Text("Select a destination to fly to")
                                    .fontWeight(.light)
                                    .foregroundStyle(.gray)
                            }

                            FlightOptionPicker(selectedOption: $flightViewModel.selectedOption,
                                               options: ["One way", "Round", "Multicity"])

                            VStack(spacing: 0) {
                                ZStack(alignment: .trailing) {
                                    VStack(spacing: 12) {
                                        DestinationPicker(flightViewModel: flightViewModel, 
                                                          flight: flightViewModel.selectedFlight,
                                                          flightOption: .arrival)
                                        
                                        DestinationPicker(flightViewModel: flightViewModel, 
                                                          flight: flightViewModel.selectedDepartureFlight,
                                                          flightOption: .departure)
                                    }
                                    
                                    Button {

                                    } label: {
                                        Image(systemName: "arrow.up.arrow.down")
                                            .padding(.all, 8)
                                            .foregroundStyle(.gray)
                                            .background(Circle().fill(Color.white))
                                            .overlay(
                                                Circle()
                                                    .stroke()
                                                    .foregroundStyle(.gray)
                                            )
                                    }
                                    .offset(y: -2)
                                }
                            }


                            HStack(spacing: -8) {
                                DatePickerView(selectedDate: $flightViewModel.departureDate,
                                               title: "Departure", 
                                               flightViewModel: flightViewModel)
                                
                                DatePickerView(selectedDate: $flightViewModel.arrivalDate,
                                               title: "Return",
                                               flightViewModel: flightViewModel)
                                .disabled(flightViewModel.validateReturnDate())
                            }

                            HStack(spacing: -8) {
                                TravellersPickerView(selectedAdults: $flightViewModel.selectedAdults, 
                                                     selectedChildren: $flightViewModel.selectedChildren,
                                                     title: "Travellers")
                                
                                ClassPickerView(selectedOption: $flightViewModel.selectedClass,
                                                title: "Class")
                            }

                            ButtonView(title: "Search", style: .primary) {

                            }
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                        .shadow(radius: 4)
                        .padding(.horizontal)

                        VStack(spacing: -36) {
                            HStack {
                                Text("Personal offers")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Spacer()
                                Text("See all")
                                    .foregroundStyle(.red)
                            }
                            .padding()
                            
                            CarouselView()
                                .frame(height: 200)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                do {
                    try await userViewModel.loadCurrentUser()
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
    }
}


#Preview {
    HomeScreenView(userViewModel: UserViewModel(), flightViewModel: FlightViewModel())
}
