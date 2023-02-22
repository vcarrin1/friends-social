//
//  HomeView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/14/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var eventModal = false
    @State var updateModal = false
    var backgroundColor = Color(.secondarySystemBackground)
    @Environment(\.managedObjectContext) var context
    
    // Fetch events from core data
    @FetchRequest(entity: Event.entity(),
    sortDescriptors: [NSSortDescriptor(key: "createTime", ascending: false)])
    var events: FetchedResults<Event>
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Image("social-events")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .aspectRatio(contentMode: .fill)
                        .frame(maxHeight: 300)
                        .clipShape(Shapes.roundedRectangleShape)
                        
                    VStack(alignment: .leading) {
                        Text("Events")
                            .font(Font.title).bold()
                            .foregroundColor(.secondary)
                        ForEach(events) { event in
                            ZStack(alignment: .leading) {
                                Rectangle().fill(Color.white).cornerRadius(10)
                                HStack {
                                    Image(systemName:"person.circle").resizable().frame(width:30,height:30).clipShape(Circle()).padding(5).background(Circle().foregroundColor(Colors.lightGrey))
                                    VStack(alignment: .leading) {
                                        Text(event.titleWrap).font(.system(size: 20))
                                        Text("by \(event.organizerWrap)").font(.system(size: 14))
                                        Text("id \(event.idWrap)").font(.system(size: 14))
                                        HStack {
                                            Text("when: \(event.createTimeWrap)").font(.system(size: 14))
                                        }
                                        Text("where: \(event.placeWrap)").font(.system(size: 14))
                                        Divider()
                                        HStack {
                                            Text("Users: You").font(.system(size: 14))
                                            ForEach(event.users, id: \.self) { user in
                                                Text("\(user.firstNameWrap) \(user.lastNameWrap)").font(.system(size: 14))
                                            }
                                        }
                                    }
                                    
                                    Button(action: {
                                        self.updateModal.toggle()
                                    }) {
                                        Image(systemName: "pencil.circle")
                                    }
                                    .padding(.trailing, 20)
                                    .imageScale(.large)
                                    .font(Font.title)
                                    .sheet(isPresented: $updateModal) {
                                        UpdateEventView(event_id: event.idWrap)
                                    }
                                }.padding(.leading, 20)
                            }
                            .padding(.vertical)
                            .background(Rectangle().fill(BackgroundStyle()))
                            .clipShape(Shapes.roundedRectangleShape)
                            .overlay(
                                Shapes.roundedRectangleShape
                                    .inset(by: 0.5)
                                    .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                            )
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                self.context.delete(self.events[index])
                            }
                            try! self.context.save()
                        }
                        
                    }
                }
                .padding()
                .frame(minWidth: 200, idealWidth: 700)
                .frame(maxWidth: .infinity)
            }
            .background(backgroundColor.ignoresSafeArea())
            .navigationTitle("Welcome")
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.eventModal.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(AddButtonStyle())
                    .padding(.trailing)
                    .sheet(isPresented: $eventModal) {
                        CreateEventView().environmentObject(Friends()).environmentObject(Places())
                    }
                }.padding(.bottom, 20)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
