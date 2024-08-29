//
//  HomeScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 28. 8. 2024..
//

import SwiftUI

struct HomeScreenView: View {

    @ObservedObject var userViewModel: UserViewModel
    @State private var selectedOption: String = "One way"
    @State private var selectedDate: Date = Date()

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
                                Text("Welcome back Denis.")
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("Select a destination to fly to")
                                    .fontWeight(.light)
                                    .foregroundStyle(.gray)
                            }

                            FlightOptionPicker(selectedOption: $selectedOption,
                                               options: ["One way", "Round", "Multicity"])

                            VStack(spacing: 0) {
                                ZStack(alignment: .trailing) {
                                    VStack(spacing: 12) {
                                        DestinationPicker(flightOption: .arrival,
                                                          town: "Mostar",
                                                          airportCode: "MST",
                                                          airportFullName: "Mostar International Airport")
                                        
                                        DestinationPicker(flightOption: .departure,
                                                          town: "New York",
                                                          airportCode: "LGA",
                                                          airportFullName: "Subhash Chandra International Airport")
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
                                DatePickerView(selectedDate: .constant(Date()),
                                               title: "Departure")
                                
                                DatePickerView(selectedDate: .constant(Date()),
                                               title: "Return")
                            }

                            HStack(spacing: -8) {
                                PickerView(selectedOption: .constant("1 Adult"),
                                                  title: "Traveller",
                                                  options: ["Option 1", "Option 2", "Option 3"])
                                
                                PickerView(selectedOption: .constant("Economy"),
                                                  title: "Class",
                                                  options: ["Option 1", "Option 2", "Option 3"])
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
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    HomeScreenView(userViewModel: UserViewModel())
}
