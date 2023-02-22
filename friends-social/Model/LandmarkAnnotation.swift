//
//  LandmarkAnnotation.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/23/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import MapKit
import UIKit

final class LandmarkAnnotation: NSObject, MKAnnotation, Identifiable {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(landmarks: Landmark) {
        self.title = landmarks.placemark.name
        self.coordinate = landmarks.placemark.coordinate
    }
}
