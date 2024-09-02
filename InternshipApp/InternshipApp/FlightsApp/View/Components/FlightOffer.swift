//
//  FlightOffer.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 2. 9. 2024..
//

import SwiftUI

struct FlightOffer: View {
    
    var departureCode: String
    var departureTown: String
    
    var arrivalCode: String
    var arrivalTown: String
    
    var flightDuration: String
    
    var departureTime: String
    var date: Date
    
    var airCompany: String
    var price: Int
    
    @State private var focused: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text(departureCode)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(departureTown)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                
                Spacer()
                Image(systemName: "airplane.departure")
                    .padding(.all, 12)
                    .background(.blue)
                    .clipShape(Circle())
                    .foregroundStyle(.white)
                Spacer()
                
                VStack {
                    Text(arrivalCode)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(arrivalTown)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
            }
            Text("\(flightDuration) hours")
            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Time")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    HStack {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(departureTime)
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding(.horizontal)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.gray)
                        
                        VStack(alignment: .leading) {
                            Text(formatDate(date))
                                .font(.caption)
                        }
                        Spacer()
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
            Divider()
            HStack {
                Image(systemName: "airplane.departure")
                Text(airCompany)
                    .font(.title2)
                    .fontWeight(.light)
                
                Spacer()
                
                Text("$\(price)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(.lightblue))
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(focused ? .blue : Color(.systemGray4), lineWidth: focused ? 4 : 1)
        )
        .padding()
        .onTapGesture {
            focused = true
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}


#Preview {
    FlightOffer(departureCode: "MST", departureTown: "Mostar", arrivalCode: "LGA", arrivalTown: "New York", flightDuration: "12:45", departureTime: "09:30", date: Date(), airCompany: "Qatar Airways", price: 235)
}
