//
//  FlightDetailsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI
import MapKit

struct FlightDetailsScreen: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.googlegray).ignoresSafeArea()
                
                VStack {
                    HStack {
                        NavigationLink {
                            BottomBarNavigation(userViewModel: userViewModel,
                                                flightViewModel: flightViewModel,
                                                initialTab: 1)
                        } label: {
                            
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                        }
                        
                        
                        Spacer()
                        
                        Text("My flight")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(8)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.clear)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.blue.ignoresSafeArea()
                    )
                    
                    if let departureLatitude = userViewModel.selectedBookedFlight?.departureLatitude,
                       let departureLongitude = userViewModel.selectedBookedFlight?.departureLongitude,
                       let arrivalLatitude = userViewModel.selectedBookedFlight?.arrivalLatitude,
                       let arrivalLongitude = userViewModel.selectedBookedFlight?.arrivalLongitude {
                        
                        Map {
                            Annotation("\(userViewModel.selectedBookedFlight?.departureCode ?? "")\n\(userViewModel.selectedBookedFlight?.departureTown ?? "")", coordinate: CLLocationCoordinate2D(latitude: arrivalLatitude, longitude: arrivalLongitude)) {
                                Image(systemName: "airplane.departure")
                                    .padding(12)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(Circle())
                            }
                            
                            Annotation("\(userViewModel.selectedBookedFlight?.arrivalCode ?? "")\n\(userViewModel.selectedBookedFlight?.arrivalTown ?? "")", coordinate: CLLocationCoordinate2D(latitude: departureLatitude, longitude: departureLongitude)) {
                                Image(systemName: "airplane.arrival")
                                    .padding(12)
                                    .background(.blue)
                                    .foregroundStyle(.white)
                                    .clipShape(Circle())
                            }
                            
                            MapPolyline(coordinates: [
                                CLLocationCoordinate2D(latitude: departureLatitude, longitude: departureLongitude),
                                CLLocationCoordinate2D(latitude: arrivalLatitude, longitude: arrivalLongitude)
                            ])
                            .stroke(.blue, lineWidth: 5)
                            
                            Annotation("", coordinate: userViewModel.midPoint) {
                                Image(systemName: "airplane")
                                    .padding(12)
                                    .background(Color.red)
                                    .foregroundStyle(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    HStack(spacing: 16) {
                        VStack {
                            Text("Boeing 747")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text("Aircraft")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Text("SWR742")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text("Serial No")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Text("10,000m")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text("Altitude")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                        }
                        
                        VStack {
                            Text("924km/h")
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                            Text("Speed")
                                .foregroundStyle(.white)
                                .font(.subheadline)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Spacer()
                            
                            Text("\(userViewModel.selectedBookedFlight?.departureCode ?? "")")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("\(userViewModel.selectedBookedFlight?.departureTown ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("DEPARTURE")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                
                                VStack(alignment: .leading) {
                                    Text("Scheduled")
                                        .fontWeight(.bold)
                                    Text("\(userViewModel.selectedBookedFlight?.departureTime ?? "")")
                                        .foregroundStyle(.blue)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Actual")
                                        .fontWeight(.bold)
                                    Text("\(userViewModel.selectedBookedFlight?.departureTime ?? "")")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        
                        ZStack {
                            Circle()
                                .frame(width: 150)
                                .foregroundStyle(Color(.systemGray5))
                            
                            Circle()
                                .frame(width: 100)
                                .foregroundStyle(Color(.systemGray3))
                            
                            Image(ImageResource.airplane)
                                .resizable()
                                .frame(width: 150, height: 150)
                        }
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            
                            Text("\(userViewModel.selectedBookedFlight?.arrivalCode ?? "")")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("\(userViewModel.selectedBookedFlight?.arrivalTown ?? "")")
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            
                            VStack(alignment: .trailing, spacing: 12) {
                                Text("ARRIVAL")
                                    .font(.subheadline)
                                    .fontWeight(.light)
                                
                                VStack(alignment: .trailing) {
                                    Text("Scheduled")
                                        .fontWeight(.bold)
                                    Text("\(userViewModel.selectedBookedFlight?.arrivalTime ?? "")")
                                        .foregroundStyle(.blue)
                                }
                                
                                VStack(alignment: .trailing) {
                                    Text("Actual")
                                        .fontWeight(.bold)
                                    Text("\(userViewModel.selectedBookedFlight?.arrivalTime ?? "")")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                    }
                    .padding()
                    
                    VStack {
                        VStack(spacing: -24) {
                            Image(systemName: "airplane")
                                .foregroundStyle(.blue)
                            ProgressView("", value: 50.0, total: 100)
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding()
                        }
                        
                        HStack {
                            Text("Departed in \(userViewModel.selectedBookedFlight?.departureTime ?? "")")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                            
                            Text("\(String(format: "%.1f", userViewModel.calculateFlightDistance())) km")
                                .font(.caption)
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            
                            Text("Arriving in \(userViewModel.selectedBookedFlight?.arrivalTime ?? "")")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray))
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FlightDetailsScreen(userViewModel: UserViewModel(), flightViewModel: FlightViewModel())
}
