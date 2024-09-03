//
//  OnlineCheckInScreen.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 3. 9. 2024..
//

import SwiftUI
import PhotosUI

struct OnlineCheckInScreen: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Online check in")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.vertical)
                
                VStack {
                    TextFieldInput(label: "Passport number",
                                   placeholder: "Enter your passport number",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                VStack {
                    TextFieldInput(label: "Nationality",
                                   placeholder: "Enter your nationality",
                                   text: .constant(""),
                                   iconName: "")
                }
                
                HStack {
                    VStack {
                        TextFieldInput(label: "Passport expiry date",
                                       placeholder: "Enter your passport expiry date",
                                       text: .constant(""),
                                       iconName: "")
                    }
                    
                    VStack {
                        TextFieldInput(label: "Place of birth",
                                       placeholder: "Enter your place of birth",
                                       text: .constant(""),
                                       iconName: "")
                    }
                }
                
                ButtonView(title: "Confirm", style: .primary) {
                    
                }
                
                
                Break(label: "or upload a picture")
                
                PhotosPicker(
                    selection: $selectedItem,
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
                    .onChange(of: selectedItem) { _, newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .cornerRadius(10)
                        .padding(.top)
                }
            }
            .padding()
        }
    }
}

#Preview {
    OnlineCheckInScreen()
}
