//
//  ChooseSeatScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct ChooseSeatScreen: View {
    @State private var selectedSeat: String? = nil
    let rows = ["A", "B", "C", "D", "E", "F"]
    let seatNumbers = 1...10

    var body: some View {
        NavigationStack {
            VStack {
                Text("Select Your Seat")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(seatNumbers, id: \.self) { seat in
                            HStack {
                                ForEach(rows, id: \.self) { row in
                                    SeatView(seat: "\(seat)\(row)", selectedSeat: $selectedSeat)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                if let selectedSeat = selectedSeat {
                    Text("Selected Seat: \(selectedSeat)")
                        .font(.headline)
                        .padding(.top)
                }

                Button(action: {
                    // Handle seat confirmation
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
                .disabled(selectedSeat == nil) // Disable button if no seat selected
            }
        }
    }
}

struct SeatView: View {
    let seat: String
    @Binding var selectedSeat: String?
    
    var body: some View {
        Button(action: {
            selectedSeat = seat
        }) {
            Text(seat)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(width: 50, height: 50)
                .background(selectedSeat == seat ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(selectedSeat == seat ? .white : .black)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ChooseSeatScreen()
}
