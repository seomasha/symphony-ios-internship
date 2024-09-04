//
//  OnlineCheckInScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI
import PhotosUI

struct OnlineCheckInScreen: View {
    @ObservedObject var flightViewModel: FlightViewModel
    @State private var showPopover = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Online check in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.vertical)
                    
                    VStack {
                        TextFieldInput(label: "Passport number",
                                       placeholder: "Enter your passport number",
                                       text: $flightViewModel.tempPassportNumber,
                                       iconName: "")
                    }
                    
                    VStack {
                        TextFieldInput(label: "Nationality",
                                       placeholder: "Enter your nationality",
                                       text: $flightViewModel.tempNationality,
                                       iconName: "")
                    }
                    
                    HStack {
                        VStack {
                            TextFieldInput(label: "Passport expiry date",
                                           placeholder: "Enter your passport expiry date",
                                           text: $flightViewModel.tempExpiryDate,
                                           iconName: "")
                        }
                        
                        VStack {
                            TextFieldInput(label: "Place of birth",
                                           placeholder: "Enter your place of birth",
                                           text: $flightViewModel.tempPlaceOfBirth,
                                           iconName: "")
                        }
                    }
                    
                    ButtonView(title: "Confirm", style: .primary) {
                        if flightViewModel.selectedImageData != nil {
                            flightViewModel.passportImage = flightViewModel.selectedImageData
                        } else {
                            flightViewModel.passportNumber = flightViewModel.tempPassportNumber
                            flightViewModel.nationality = flightViewModel.tempNationality
                            flightViewModel.expiryDate = flightViewModel.tempExpiryDate
                            flightViewModel.placeOfBirth = flightViewModel.tempPlaceOfBirth
                        }
                    }
                    
                    
                    Break(label: "or upload a picture")
                    
                    PhotosPicker(
                        selection: $flightViewModel.selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text("Select a photo")
                                .foregroundColor(.blue)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                        }
                        .onChange(of: flightViewModel.selectedItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    flightViewModel.selectedImageData = data
                                }
                            }
                        }
                    
                    if let imageData = flightViewModel.selectedImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(10)
                            .padding(.top)
                            .onTapGesture {
                                showPopover = true
                            }
                            .popover(isPresented: $showPopover) {
                                Button {
                                    flightViewModel.selectedImageData = nil
                                    flightViewModel.passportImage = nil
                                } label: {
                                    Text("Remove image")
                                        .padding()
                                }
                                .presentationCompactAdaptation(.popover)
                            }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    OnlineCheckInScreen(flightViewModel: FlightViewModel())
}
