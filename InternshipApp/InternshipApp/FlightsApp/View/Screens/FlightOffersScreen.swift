//
//  FlightOffersScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 2. 9. 2024..
//

import SwiftUI

struct FlightOffersScreen: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                    
                    HStack {
                        VStack {
                            Text("Showing")
                                .font(.caption2)
                                .foregroundStyle(.blue)
                            Text("12")
                                .foregroundStyle(.blue)
                            Text("Results")
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
                        
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}
#Preview {
    FlightOffersScreen(flightViewModel: FlightViewModel())
}
