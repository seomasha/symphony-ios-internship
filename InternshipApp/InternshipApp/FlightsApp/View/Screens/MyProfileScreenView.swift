//
//  MyProfileScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI
import PhotosUI

struct MyProfileScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel
    @State private var showingPhotoPicker = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.lightgray).ignoresSafeArea()
                
                VStack {
                    VStack {
                        Spacer()
                        Text("My profile")
                            .foregroundStyle(.white)
                            .font(.headline)
                        HStack {
                            if let user = userViewModel.user {
                                if let selectedImage = userViewModel.selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .scaledToFit()
                                        .padding()
                                } else {
                                    AsyncImage(url: URL(string: user.profileImageURL!)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 50, height: 50)
                                                .padding()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .scaledToFit()
                                                .padding()
                                        case .failure:
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                .scaledToFit()
                                                .padding()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(user.name + " " + user.surname)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    
                                    Text("\(user.age) years")
                                        .font(.subheadline)
                                        .foregroundStyle(Color(.lightgray))
                                }
                            }
                            Spacer()
                            Button(action: {
                                showingPhotoPicker.toggle()
                            }) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding()
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .ignoresSafeArea(edges: .top)
                    
                    ScrollView {
                        ProfileCard(userViewModel: userViewModel, flightViewModel: flightViewModel)
                    }
                    
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            Task {
                do {
                    try await userViewModel.loadCurrentUser()
                } catch {
                    print("Error loading user or profile image: \(error)")
                }
            }
        }
        .photosPicker(isPresented: $showingPhotoPicker, selection: $userViewModel.selectedItem, matching: .images)
        .onChange(of: userViewModel.selectedItem) { newItem in
            Task {
                if let selectedItem = newItem {
                    if let data = try? await selectedItem.loadTransferable(type: Data.self),
                       let uiImage = UIImage(data: data) {
                        userViewModel.selectedImage = uiImage
                        try await userViewModel.uploadProfileImage(uiImage)
                    }
                }
            }
        }
    }
}

#Preview {
    MyProfileScreenView(userViewModel: UserViewModel(), flightViewModel: FlightViewModel())
}
