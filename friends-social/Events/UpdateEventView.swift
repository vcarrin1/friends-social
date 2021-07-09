//
//  UpdateEventView.swift
//  friends-social
//
//  Created by Valentina Carrington on 1/6/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct UpdateEventView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) var context
    
    @State var event_name: String = ""
    @State var place_name: String = ""
    
    // Fetch event from core data
    var fetchRequest: FetchRequest<Event>
    var eventSet: FetchedResults<Event>{ fetchRequest.wrappedValue }
    
    init(event_id: UUID) {
        fetchRequest = FetchRequest<Event>(entity: Event.entity(),
        sortDescriptors: [], predicate: NSPredicate(format: "id == %@", event_id as CVarArg))
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Event Name").font(.headline)
                TextField("Event Name", text: $event_name)
                    .padding(.all)
                    .background(Colors.lightGrey).cornerRadius(7)
                Text("Place").font(.headline)
                TextField("Place Name", text: $place_name)
                    .padding(.all)
                    .background(Colors.lightGrey).cornerRadius(7)
                
                Button(action: {
                    context.performAndWait {
                      eventSet.first?.title = self.event_name
                      try? context.save()
                    }
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
            .navigationBarTitle("Event: \(eventSet.first?.titleWrap ?? "")", displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close").bold()
                })
            .onAppear {
                self.event_name = eventSet.first?.titleWrap ?? ""
                self.place_name = eventSet.first?.placeWrap ?? ""
            }
        }
    }
}

//struct UpdateEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateEventView(event: Event)
//    }
//}
