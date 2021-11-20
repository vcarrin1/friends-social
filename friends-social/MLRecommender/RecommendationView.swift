//
//  RecommendationView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI
import Combine
import CoreML


struct RecommendationView: View {
    @ObservedObject var topRecommendations = Recommender()
    @ObservedObject var searchPlaces: SearchPlaces
    @Environment(\.presentationMode) private var presentationMode
   
    var body: some View {
        NavigationView {
            List(topRecommendations.places) { place in
                VStack (alignment: .leading) {
                    Text(place.name)
                    Text("\(place.score)")
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                }.onTapGesture {
                    self.searchPlaces.searchQuery = place.name
                    self.searchPlaces.getNearByLandmarks()
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.navigationBarTitle("Recommended Places", displayMode: .inline)
        }
    }
}
