//
//  MyProfileScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 21. 8. 2024..
//

import SwiftUI

struct MyProfileScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    
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
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                    .ignoresSafeArea(edges: .top)
                    
                    ScrollView {
                        ProfileCard(userViewModel: userViewModel)
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
    }
}

#Preview {
    MyProfileScreenView(userViewModel: UserViewModel())
}
