//
//  SeatView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 4. 9. 2024..
//

import SwiftUI

struct SeatView: View {
    let seat: Seat
    @Binding var selectedSeat: Seat?
    
    var body: some View {
        Button(action: {
            selectedSeat = seat
        }) {
            Text(seat.seatNo)
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(width: 50, height: 50)
                .background(selectedSeat?.seatNo == seat.seatNo ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(selectedSeat?.seatNo == seat.seatNo ? .white : .black)
                .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
