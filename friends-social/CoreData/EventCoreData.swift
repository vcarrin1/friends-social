//
//  EventCoreData.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/17/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var place: String?
    @NSManaged public var organizer: String?
    @NSManaged public var updateTime: Date?
    @NSManaged public var createTime: Date?
    @NSManaged public var user: NSSet?
    
    public var idWrap: UUID {
        return id ?? UUID()
    }
    
    public var titleWrap: String {
        return title ?? "(No Event Title)"
    }
    
    public var placeWrap: String {
        return place ?? "(No Event Place)"
    }
    
    public var organizerWrap: String {
        return organizer ?? "(No Organizer)"
    }
    
    public var createTimeWrap: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        formatter.timeZone = .current
        let createTimeFormatted = formatter.string(from: createTime ?? Date())
        return createTimeFormatted
    }
    
    public var users: [User] {
        let set = user as? Set<User> ?? []
        return set.sorted {
            $0.firstNameWrap < $1.firstNameWrap
        }
    }
}

// MARK: Generated accessors for user
extension Event {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

extension Event : Identifiable {

}
