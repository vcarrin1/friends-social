//
//  MapView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//
import SwiftUI
import MapKit
import Combine

struct MapView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @StateObject var locationManager = LocationManager()
    @ObservedObject var searchPlaces = SearchPlaces()
    @EnvironmentObject var selectedLandmarks: Places
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 32.715736, longitude: -117.161087),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var cancellable: AnyCancellable?
    
    @State var placeListModal = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapRepresentable(landmarks: self.searchPlaces.landmarks, centerCoordinate: $centerCoordinate, annotationOnTap: { title in
                print("Title clicked", title)
            }).edgesIgnoringSafeArea(.all)
            
            HStack {
                TextField("Search Places", text: $searchPlaces.searchQuery, onEditingChanged: { _ in}) {
                    self.searchPlaces.getNearByLandmarks()
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding(5)
                
                Button(action: {
                    self.placeListModal.toggle()
                }) { Text("Found (\(self.searchPlaces.landmarks.count))") }
                .buttonStyle(BorderedButtonStyle(bgColor: .black))
                .padding(5)
                .sheet(isPresented: $placeListModal) {
                    PlaceListView(landmarks: self.searchPlaces.landmarks)
                }
            }
            
        }.onAppear {
            setCurrentLocation()
        }
    }

    private func setCurrentLocation() {

        cancellable = locationManager.$location.sink { location in
            region = MKCoordinateRegion(center: location?.coordinate ?? CLLocationCoordinate2D(), latitudinalMeters: 500, longitudinalMeters: 500)
        }

    }
}
