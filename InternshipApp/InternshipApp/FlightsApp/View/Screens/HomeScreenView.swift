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
                Color(.lightgray).ignoresSafeArea()
                VStack(spacing: 20) {
                    VStack {
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
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(.blue)
                    
                    VStack {
                        VStack(spacing: 24) {
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
                            
                            Picker("Travel options", selection: $selectedOption) {
                                Text("Mostar")
                            }.pickerStyle(.menu)
                            
                            Picker("Travel options", selection: $selectedOption) {
                                Text("New york")
                            }.pickerStyle(.menu)
                            
                            HStack {
                                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            }
                            
                            HStack {
                                Picker("Traveller", selection: $selectedOption) {
                                    Text("1 adult")
                                }
                                Picker("Class", selection: $selectedOption) {
                                    Text("Economy")
                                }
                            }
                            
                            ButtonView(title: "Search", style: .primary) {
                                
                            }
                        }
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    
                    VStack {
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
                    }
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    HomeScreenView(userViewModel: UserViewModel())
}
