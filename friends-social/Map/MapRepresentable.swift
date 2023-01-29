//
//  MapRepresentable.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI
import MapKit


struct MapRepresentable: UIViewRepresentable {
    
    let landmarks: [Landmark]
    @StateObject var locationManager = LocationManager()
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @EnvironmentObject var selectedLandmarks: Places
    var annotationOnTap: (_ title: String) -> Void

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.delegate = context.coordinator
        map.showsUserLocation = true
        return map
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapRepresentable>) {
        updateAnnotations(from: uiView)
    }

    private func updateAnnotations(from mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        let annotations = self.landmarks.map(LandmarkAnnotation.init)
        mapView.addAnnotations(annotations)
    }
    
//    func addCircle(to view: MKMapView) {
//        if !view.overlays.isEmpty { view.removeOverlays(view.overlays) }
//
//        guard var circle = circle else { return }
//
//
//        //HERE
//        let center: CLLocationCoordinate2D! = CLLocationCoordinate2D()
//        // How to set center with the map center (MapView.centerCoordinate) ?
//
//
//        circle = MKCircle(center: center, radius: CLLocationDistance(1000))
//
//        let mapRect = circle.boundingMapRect
//        view.setVisibleMapRect(mapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
//        view.addOverlay(circle)
//    }

}
