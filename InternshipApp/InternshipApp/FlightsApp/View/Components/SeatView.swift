//
//  SeatView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 4. 9. 2024..
//

import SwiftUI

struct SeatView: View {
    let seat: String
    @Binding var selectedSeat: String
    
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
    SeatView(seat: "2c", selectedSeat: .constant(""))
}
