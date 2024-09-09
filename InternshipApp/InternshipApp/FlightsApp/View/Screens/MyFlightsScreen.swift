//
//  MyFlightsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 9. 9. 2024..
//

import SwiftUI

struct MyFlightsScreen: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationStack {
            Text("Booked flights")
                .font(.title)
                .foregroundStyle(.blue)
            
            ScrollView {
                ForEach(userViewModel.bookedFlights, id: \.id) { flight in
                    VStack {
                        Text(flight.airCompany)
                        Text(flight.arrivalCode)
                        Text(flight.departureCode)
                        Text("\(flight.price)")
                        Text("\(flight.date)")
                    }
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MyFlightsScreen(userViewModel: UserViewModel())
}
