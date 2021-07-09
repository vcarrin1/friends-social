//
//  CreateEventView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/16/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct CreateEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var friends: Friends
    @EnvironmentObject var selectedLandmarks: Places
    
    @State var event_name: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Event Name").font(.headline)
                TextField("Enter a name", text: $event_name)
                    .padding(.all)
                    .background(Colors.lightGrey).cornerRadius(7)
                
                Text("Friends").font(.headline)
                NavigationLink(destination: FriendsView()) {
                    ZStack(alignment: .leading)  {
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(.white)
                            .opacity(0)
                            .background(Colors.lightGrey).cornerRadius(7)
                            .frame(height: 50)
                        HStack {
                            Text((friends.details.isEmpty) ? "Add friends" : "Friends").padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right").padding(.trailing, 15).font(.system(size: 25))
                        }
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                if (!friends.details.isEmpty) {
                    ForEach(friends.details) { friend in
                        Text("\(friend.firstName) \(friend.lastName)")
                    }
                }
                
                Text("Places").font(.headline)
                NavigationLink(destination: MapView()) {
                    ZStack(alignment: .leading)  {
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundColor(.white)
                            .opacity(0)
                            .background(Colors.lightGrey).cornerRadius(7)
                            .frame(height: 50)
                        HStack {
                            Text((selectedLandmarks.places.isEmpty) ? "Search for Places" : "Places").padding(.leading, 20)
                            Spacer()
                            Image(systemName: "chevron.right").padding(.trailing, 15).font(.system(size: 25))
                        }
                        
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                if (!selectedLandmarks.places.isEmpty) {
                    ForEach(selectedLandmarks.places, id: \.self) { landmark in
                        Text("\(landmark.title ?? "no place")")
                    }.onDelete(perform: removePlaces)
                }
                
                Button(action: {
                    let event = Event(context: context)
                    event.id = UUID()
                    event.title = self.event_name
                    event.organizer = "Valentina Carrington"
                    event.place = selectedLandmarks.places.first?.title
                    event.createTime = Date()
                     
                    for friend in friends.details {
                       let user = User(context: context)
                       user.firstName = friend.firstName
                       user.lastName = friend.lastName
                       event.addToUser(user)
                    }
                    try! self.context.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Spacer()
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
                .background(Color.blue).cornerRadius(4)
                .padding(.horizontal, 50)
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 15)
            .navigationBarTitle("Create Event", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close").bold()
                })
        }
    }
    
    func removePlaces(at offsets: IndexSet) {
        self.selectedLandmarks.places.remove(atOffsets: offsets)
    }
}

//struct CreateEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateEventView()
//    }
//}
