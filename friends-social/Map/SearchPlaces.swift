//
//  SearchPlaces.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/18/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//
import Foundation
import Combine
import MapKit

class SearchPlaces: NSObject, ObservableObject {
    
    @Published var searchQuery = ""
    @Published var landmarks: [Landmark] = [Landmark]()
    
    public func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.map {
                    Landmark(placemark: $0.placemark)
                }
                Task {
                    await self.getData()
                }
                print("Lamdmarks \(self.landmarks)")
            }
        }
    }
    
    private func getData() async {
        guard let landmark = try? JSONEncoder().encode(self.landmarks) else { return }
        
        do {
            let decodedLandmark = try JSONDecoder().decode([Landmark].self, from: landmark)
            print("decodedLandmark \(decodedLandmark)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
        } catch {
            print("Error \(error)")
        }
    }

}

