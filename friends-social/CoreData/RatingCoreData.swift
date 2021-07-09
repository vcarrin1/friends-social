//
//  RatingCoreData.swift
//  friends-social
//
//  Created by Valentina Carrington on 1/6/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import Foundation
import CoreData


@objc(Rating)
public class Rating: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        return NSFetchRequest<Rating>(entityName: "Rating")
    }

    @NSManaged public var place: String?
    @NSManaged public var rating: Int16
    
    public var placeWrap: String {
        return place ?? "(No Place)"
    }
    
    public var ratingWrap: Int16 {
        return rating
    }

}

extension Rating : Identifiable {

}
