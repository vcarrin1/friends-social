//
//  Landmark.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/23/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import MapKit

struct Landmark: Codable {
    @CodablePlacemark var placemark: MKPlacemark
    var id: UUID {
        return UUID()
    }
    
}

@propertyWrapper
struct CodablePlacemark {
    var wrappedValue: MKPlacemark
}

extension CodablePlacemark: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        guard let placemark = try NSKeyedUnarchiver.unarchivedObject(ofClass: MKPlacemark.self, from: data) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid placemark"
            )
        }
        wrappedValue = placemark
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let data = try NSKeyedArchiver.archivedData(withRootObject: wrappedValue, requiringSecureCoding: true)
        try container.encode(data)
    }
}



//struct Landmark {
//
//    let placemark: MKPlacemark
//
//    var id: UUID {
//        return UUID()
//    }
//
//    var name: String {
//        self.placemark.name ?? ""
//    }
//
//    var title: String {
//        self.placemark.title ?? ""
//    }
//
//    var coordinate: CLLocationCoordinate2D {
//        self.placemark.coordinate
//    }
//}
