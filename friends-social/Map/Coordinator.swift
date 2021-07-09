//
//  Coordinator.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import MapKit
import SwiftUI

class Coordinator: NSObject, MKMapViewDelegate {
    var control: MapRepresentable
    
    
    init(_ control: MapRepresentable) {
        self.control = control
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        if let annotationView = views.first {
            if let annotation = annotationView.annotation {
                if annotation is MKUserLocation {
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        if !mapView.showsUserLocation {
           control.centerCoordinate = mapView.centerCoordinate
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       view.canShowCallout = true

       let btn = UIButton(type: .contactAdd)
       view.rightCalloutAccessoryView = btn
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let mark = view.annotation as? LandmarkAnnotation else { return }
//        if let index = self.control.selectedLandmarks.places.firstIndex(where: {$0.title == mark.title}) {
//            self.control.selectedLandmarks.places.remove(at: index)
//        }
        print("diselected \(mark.title ?? "no title")")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? LandmarkAnnotation,
               let placeName = annotation.title else { return }
        self.control.annotationOnTap(placeName)
        if (!self.control.selectedLandmarks.places.contains(where: {$0.title == placeName})) {
            self.control.selectedLandmarks.places.append(annotation)
        }
     }

}
