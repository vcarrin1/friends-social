//
//  City.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/13/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import MapKit


struct City: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
