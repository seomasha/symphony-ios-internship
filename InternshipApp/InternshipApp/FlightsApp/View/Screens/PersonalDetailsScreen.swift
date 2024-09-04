//
//  PersonalDetailsScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI

struct PersonalDetailsScreen: View {
    
    @ObservedObject var flightViewModel: FlightViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Personal details")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack {
                    TextFieldInput(label: "Full name",
                                   placeholder: "Enter your full name",
                                   text: $flightViewModel.tempFullName,
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Email address",
                                   placeholder: "Enter your email address",
                                   text: $flightViewModel.tempEmail,
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Phone number",
                                   placeholder: "Enter your phone number",
                                   text: $flightViewModel.tempPhoneNo,
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Home address",
                                   placeholder: "Enter your home address",
                                   text: $flightViewModel.tempHomeAddress,
                                   iconName: "")
                }
                
                ButtonView(title: "Confirm", style: .primary) {
                    flightViewModel.fullName = flightViewModel.tempFullName
                    flightViewModel.email = flightViewModel.tempEmail
                    flightViewModel.phoneNo = flightViewModel.tempPhoneNo
                    flightViewModel.homeAddress = flightViewModel.tempHomeAddress
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    PersonalDetailsScreen(flightViewModel: FlightViewModel())
}
