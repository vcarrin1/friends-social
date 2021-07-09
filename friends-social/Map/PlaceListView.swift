//
//  PlaceListView.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/30/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import SwiftUI
import MapKit

struct PlaceListView: View {
    
    let landmarks: [Landmark]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.landmarks, id: \.id) { landmark in
                    VStack(alignment: .leading) {
                        Text(landmark.name).fontWeight(.bold)
                        Text(landmark.title)
                    }
                }
            }.navigationBarTitle("Searched Places", displayMode: .inline)
        }
    }
}

struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView(landmarks: [Landmark(placemark: MKPlacemark())])
    }
}
