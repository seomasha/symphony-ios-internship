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
                        Text("FLY MOSTAR")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()

                    }
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(.blue)

                    VStack {
                        VStack {
                            Text("Welcome back Denis.")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Select a destination to fly to")
                                .fontWeight(.light)
                                .foregroundStyle(.gray)
                            
                            Picker("Travel options", selection: $selectedOption) {
                                Text("One way")
                                Text("Round")
                                Text("Multicity")
                            }
                            .pickerStyle(.segmented)
                            
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
                            
                            Spacer()
                        }
                        .padding()
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .shadow(radius: 4)
                    .padding(.horizontal)
                    .ignoresSafeArea(edges: .top)
                    
                    HStack {
                        Text("Personal offers")
                        Spacer()
                        Text("See all")
                    }
                    .padding()
                    
                    CarouselView()
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    HomeScreenView(userViewModel: UserViewModel())
}
