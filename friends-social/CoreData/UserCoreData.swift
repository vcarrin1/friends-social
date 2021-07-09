//
//  UserCoreData.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/17/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import CoreData


@objc(User)
public class User: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phone: Int16
    @NSManaged public var address: String?
    @NSManaged public var event: NSSet?
    
    public var firstNameWrap: String {
        return firstName ?? "(No First Name)"
    }
    
    public var lastNameWrap: String {
        return lastName ?? "(No Last Name)"
    }

}

// MARK: Generated accessors for event
extension User {

    @objc(addEventObject:)
    @NSManaged public func addToEvent(_ value: Event)

    @objc(removeEventObject:)
    @NSManaged public func removeFromEvent(_ value: Event)

    @objc(addEvent:)
    @NSManaged public func addToEvent(_ values: NSSet)

    @objc(removeEvent:)
    @NSManaged public func removeFromEvent(_ values: NSSet)

}

extension User : Identifiable {

}
