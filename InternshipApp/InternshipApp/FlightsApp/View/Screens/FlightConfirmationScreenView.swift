//
//  FlightConfirmationScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 6. 9. 2024..
//

import SwiftUI

struct FlightConfirmationScreenView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(ImageResource.background)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 250)
                    .overlay(
                        .blue.opacity(0.6)
                    )
                    .blendMode(.plusDarker)
                
                
                VStack(spacing: 32) {
                    HStack {
                        Image(systemName: "airplane.departure")
                        Text("Qatar Airways")
                        Spacer()
                        Text("July 15th, 09:30AM")
                    }
                    
                    HStack {
                        VStack {
                            Text("09:30 AM")
                            Text("MST")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Image(systemName: "airplane.departure")
                            Text("10h30m")
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("09:30 AM")
                            Text("MST")
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        VStack {
                            Text("Economy")
                            Text("Economy")
                        }
                        
                        VStack {
                            Text("Economy")
                            Text("Economy")
                        }
                        
                        VStack {
                            Text("Economy")
                            Text("Economy")
                        }
                        
                        VStack {
                            Text("Economy")
                            Text("Economy")
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(ImageResource.airplaneIcon)
                            .resizable()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text("Jane Doe")
                            Text("24 years, female")
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chair.lounge.fill")
                        Text("29A")
                    }
                    
                    DottedLine()
                    
                    Image(systemName: "qrcode")
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                .padding()
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(.systemGray4), lineWidth: 1)
                        .shadow(radius: 1)
                )
                .padding()
                
                ButtonView(title: "Print ticket", style: .primary) {
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .offset(y: -125)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    FlightConfirmationScreenView()
}
