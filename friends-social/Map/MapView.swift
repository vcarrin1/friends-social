//
//  MapView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//
import SwiftUI
import MapKit

struct MapView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @ObservedObject var locationManager = LocationManager()
    @ObservedObject var searchPlaces = SearchPlaces()
    @EnvironmentObject var selectedLandmarks: Places
    @ObservedObject var topRecommendations = Recommender()
    
    @State var recomendationsModal = false
    @State var placeListModal = false
    
    var body: some View {
        ZStack(alignment: .top) {
            MapRepresentable(landmarks: self.searchPlaces.landmarks, centerCoordinate: $centerCoordinate, annotationOnTap: { title in
                print("Title clicked", title)
            }).edgesIgnoringSafeArea(.all)
            
            TextField("Search Places", text: $searchPlaces.searchQuery, onEditingChanged: { _ in}) {
                self.searchPlaces.getNearByLandmarks()
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding().offset(y: 40)
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Text("Recommendations").font(.headline).padding(.leading, 15)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 0) {
                        ForEach(topRecommendations.places) { place in
                            ZStack {
                                Rectangle().fill(Color.white).padding().cornerRadius(20)
                                VStack {
                                    Text(place.name)
                                    Text("\(place.score)")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color.gray)
                                }.onTapGesture {
                                    self.searchPlaces.searchQuery = place.name
                                    self.searchPlaces.getNearByLandmarks()
                                }
                            }.frame(width: 220, height: 120)
                        }
                    }
                }
            }
            
//            VStack {
//                Spacer()
//                HStack {
//                    Spacer()
//                    Button(action: {
//                        self.recomendationsModal.toggle()
//                    }) { Text("Recommendations") }
//                    .buttonStyle(BorderedButtonStyle(bgColor: .black))
//                    .padding(.trailing)
//                    .sheet(isPresented: $recomendationsModal) {
//                        RecommendationView(searchPlaces: self.searchPlaces)
//                    }
//
//                    Button(action: {
//                        self.placeListModal.toggle()
//                    }) { Text("Searched Places (\(self.searchPlaces.landmarks.count))") }
//                    .buttonStyle(BorderedButtonStyle(bgColor: .black))
//                    .padding(.trailing)
//                    .sheet(isPresented: $placeListModal) {
//                        PlaceListView(landmarks: self.searchPlaces.landmarks)
//                    }
//                }.padding(.bottom, 20)
//            }
            
        }
    }
}
