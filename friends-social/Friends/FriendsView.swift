//
//  Friends.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/14/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI
import Contacts

struct FriendsView: View {
    
    @EnvironmentObject var store: ContactStore
    @State private var searchText : String = ""
    
    @State private var checked = false

    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search Friends")
            List {
                ForEach(self.store.contacts.filter {
                    self.searchText.isEmpty ? true : $0.givenName.lowercased().contains(self.searchText.lowercased())
                }, id: \.self.name) {
                    (contact: CNContact) in
                    
                    ContactRow(contact: contact).padding(.horizontal)
                }
            }.onAppear{
                DispatchQueue.main.async {
                    self.store.fetchContacts()
                }
            }
            .navigationBarTitle(Text("Create an event with friends"))
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ContactStore())
    }
}



class ContactStore: ObservableObject {
    
    @Published var contacts: [CNContact] = []
    @Published var error: Error? = nil
    
    func fetchContacts() {
        
        
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            
            if granted {

                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                request.sortOrder = .givenName
                
                do {

                    var contactsArray = [CNContact]()
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        if (contact.phoneNumbers.first?.value.stringValue) != nil{
                            contactsArray.append(contact)
                        }
                    })
                    
                    self.contacts = contactsArray
                    
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
}

struct ContactRow: View {
    
    var contact: CNContact
    @State private var checked = false
    @EnvironmentObject var friends: Friends
    @State var friend = Friend()
    
    var body: some View {
        Button(action: {
            self.checked.toggle()
            if (self.checked == true) {
                self.friend.firstName = self.contact.givenName
                self.friend.lastName = self.contact.familyName
                self.friend.selected = true
                self.friends.details.append(self.friend)
            } else {
                self.friend.selected = false
                if let index = self.friends.details.firstIndex(where: {$0.firstName == self.contact.givenName}) {
                    self.friends.details.remove(at: index)
                }
            }
            print(self.friends.hasElement(contact: self.contact))
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(contact.name).font(.headline)
                    Text(contact.phoneNumbers.first?.value.stringValue ?? "").font(.subheadline)
                }
                Spacer()
                Toggle("Complete", isOn: $checked)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .toggleStyle(CircleToggleStyle())
    }
}

extension CNContact: Identifiable {
    var name: String {
        return [givenName, familyName].filter{ $0.count > 0}.joined(separator: " ")
    }
}
