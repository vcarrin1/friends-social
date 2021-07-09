//
//  Users.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/20/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//



import Contacts

class Friends: ObservableObject {
    @Published var details = [Friend]()
    
    func hasElement(contact: CNContact) -> Bool {
        print("contact \(contact)")
        print("details \(self.details)")
        return self.details.contains(where: {$0.firstName == contact.givenName})
    }
}

struct Friend: Identifiable, Equatable, Hashable {
  var id = UUID()
  var selected: Bool = false
  var firstName: String = ""
  var lastName: String = ""
  var phone: Int16 = 0
  var address: String = ""
}

