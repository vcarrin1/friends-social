//
//  LocationManager.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/23/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .restricted,.denied,.notDetermined:
            // report error, do something
            print("error")
        default:
            // location si allowed, start monitoring
            manager.startUpdatingLocation()
        }
    }
    
//    func locationManager(manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print(status)
//        // do something with the error
//    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
           return
        }
        self.location = location
    }
}
