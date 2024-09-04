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
                    VStack(spacing: 16) {
                        ForEach(flightViewModel.seatNumbers, id: \.self) { seat in
                            HStack {
                                ForEach(flightViewModel.rows, id: \.self) { row in
                                    SeatView(seat: "\(seat)\(row)",
                                             selectedSeat: $flightViewModel.tempSelectedSeat)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if flightViewModel.tempSelectedSeat != "" {
                    Text("Selected Seat: \(flightViewModel.tempSelectedSeat)")
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
                .disabled(flightViewModel.tempSelectedSeat == "")
            }
        }
    }
}

#Preview {
    ChooseSeatScreen(flightViewModel: FlightViewModel())
}
