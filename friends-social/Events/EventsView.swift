//
//  EventsView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/13/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI
import MapKit

struct EventsView: View {
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.999733, longitude: -98.678503),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    @ObservedObject var searchPlaces: SearchPlaces
    
    init() {
        self.searchPlaces = SearchPlaces()
    }
    
    var coorrdinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: 34.011_286,
            longitude: -116.166_868
        )
    }
    
    var body: some View {
        VStack {
           SearchBar(text: $searchPlaces.searchQuery, placeholder: "Search Places")
//           List(searchPlaces.completions) { completion in
////            NavigationLink(destination: MapView()) {
////                VStack(alignment: .leading) {
////                    Text(completion.title)
////                    Text(completion.subtitle)
////                        .font(.subheadline)
////                        .foregroundColor(.gray)
////                }
////              }
//           }.navigationBarTitle(Text("Search near me"))
        }

//        VStack {
//
//            Map(coordinateRegion: $region, annotationItems: cities) { city in
//                MapAnnotation(
//                    coordinate: city.coordinate,
//                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
//                ) {
//                    Circle()
//                        .stroke(Color.green)
//                        .frame(width: 44, height: 44)
//                }
//            }
//
//            Button("zoom out") {
//                withAnimation {
//                    region.span = MKCoordinateSpan(
//                        latitudeDelta: 100,
//                        longitudeDelta: 100
//                    )
//                }
//            }
//        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
    }
}
