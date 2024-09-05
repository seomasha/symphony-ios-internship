//
//  ChooseSeatScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct ChooseSeatScreen: View {
    @ObservedObject var flightViewModel: FlightViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Your Seat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: flightViewModel.seatColumns, spacing: 16) {
                        ForEach(flightViewModel.seats) { seat in
                            SeatView(seat: seat, selectedSeat: $flightViewModel.tempSelectedSeat)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                
                if flightViewModel.tempSelectedSeat != nil {
                    Text("Selected Seat: \(flightViewModel.tempSelectedSeat?.seatNo ?? "")")
                        .font(.headline)
                        .padding(.top)
                }
                
                Button(action: {
                    flightViewModel.selectedSeat = flightViewModel.tempSelectedSeat
                }) {
                    Text("Confirm Selection")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                .disabled(flightViewModel.tempSelectedSeat == nil)
            }
        }
    }
}

#Preview {
    ChooseSeatScreen(flightViewModel: FlightViewModel())
}
