//
//  FlightDetailsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI
import MapKit

struct FlightDetailsScreen: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    let mostar = CLLocationCoordinate2D(latitude: 43.2901,
                                        longitude: 17.8362)
    
    let newYork = CLLocationCoordinate2D(latitude: 40.7766,
                                         longitude: 73.8742)
    
    private var midPoint: CLLocationCoordinate2D {
        let midLat = (mostar.latitude + newYork.latitude) / 2
        let midLon = (mostar.longitude + newYork.longitude) / 2
        return CLLocationCoordinate2D(latitude: midLat, longitude: midLon)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.googlegray).ignoresSafeArea()
                
                VStack {
                    HStack {
                        Text("My flight")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .padding(8)
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.blue.ignoresSafeArea()
                    )
                    
                    Map() {
                        Annotation("LGA\nNewYork", coordinate: mostar) {
                            Image(systemName: "airplane.departure")
                                .padding(12)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                        }
                        
                        Annotation("MST\nMostar", coordinate: newYork) {
                            Image(systemName: "airplane.arrival")
                                .padding(12)
                                .background(.blue)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                        }
                        
                        MapPolyline(coordinates: [mostar, newYork])
                            .stroke(.blue, lineWidth: 5)
                        
                        Annotation("", coordinate: midPoint) {
                            Image(systemName: "airplane")
                                .padding(12)
                                .background(Color.red)
                                .foregroundStyle(.white)
                                .clipShape(Circle())
                        }
                    }
                    .frame(width: .infinity, height: 250)
                    .allowsHitTesting(false)
                    
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
                    .frame(width: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    HStack(spacing: 16) {
                        VStack(alignment: .leading) {
                            Spacer()
                            
                            Text("MST")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Mostar")
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
                                    Text("09:30Am")
                                        .foregroundStyle(.blue)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text("Actual")
                                        .fontWeight(.bold)
                                    Text("09:50Am")
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
                            
                            Text("MST")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Mostar")
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
                                    Text("09:30Am")
                                        .foregroundStyle(.blue)
                                }
                                
                                VStack(alignment: .trailing) {
                                    Text("Actual")
                                        .fontWeight(.bold)
                                    Text("09:50Am")
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
                            Text("Departed in 09:30 AM")
                                .font(.caption)
                                .foregroundStyle(Color(.systemGray))
                            
                            Spacer()
                            
                            Text("2,111km")
                                .font(.caption)
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            
                            Text("Arriving in 09:30 AM")
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
    FlightDetailsScreen()
}
