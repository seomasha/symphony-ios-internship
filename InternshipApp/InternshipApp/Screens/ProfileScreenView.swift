//
//  ProfileScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 13. 8. 2024..
//

import SwiftUI

struct ProfileScreenView: View {
    
    @ObservedObject var profileViewModel: ProfileScreenViewModel
    @ObservedObject var taskViewModel: TaskViewModel
    @ObservedObject var reminderViewModel: ReminderViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if profileViewModel.image != nil {
                    Image(uiImage: profileViewModel.image!)
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
                Text(profileViewModel.name)
                    .font(.system(size: 32, weight: .semibold))
                
                Text(profileViewModel.email)
                    .font(.system(size: 16, weight: .light))
                    .foregroundStyle(.black)
                
            }.padding()
            Spacer()
        }
        .navigationTitle("My profile")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: TaskListView(taskViewModel: taskViewModel,
                                                         profileViewModel: profileViewModel,
                                                         reminderViewModel: reminderViewModel)) {
                    Image(systemName: "list.bullet")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: CreateTaskView(taskViewModel: taskViewModel,
                                                           profileViewModel: profileViewModel,
                                                           reminderViewModel: reminderViewModel)) {
                    Image(systemName: "plus")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: EditProfileView(profileViewModel: profileViewModel)) {
                    Image(systemName: "pencil")
                }
            }
        }
            
    }
}

struct ProfileScreenView_Preview: PreviewProvider {
    static var previews: some View {
        @ObservedObject var profileViewModel = ProfileScreenViewModel()
        @ObservedObject var taskViewModel = TaskViewModel()
        @ObservedObject var reminderViewModel = ReminderViewModel()
        ProfileScreenView(profileViewModel: profileViewModel,
                          taskViewModel: taskViewModel,
                          reminderViewModel: reminderViewModel)
    }
}
