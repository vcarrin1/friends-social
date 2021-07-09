//
//  Recommender.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/27/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//
import Combine
import CoreML
import SwiftUI

public class Recommender: ObservableObject {
    
    @Published var places = [Place]()
    
    // Fetch events from core data
    @FetchRequest(entity: Rating.entity(),
    sortDescriptors: [])
    var ratings: FetchedResults<Rating>
    
    init(){
        load()
    }
    
    func load() {
        do {
            let user_ratings: [String : Double] = ["Season 52" : 5, "Hacienda Colorado" : 4, "Mad Greens" : 3]
            
            let recommender = PlaceRecommender()
            let input = PlaceRecommenderInput(items: user_ratings, k: 10, restrict_: [], exclude: [])
            
            let result = try recommender.prediction(input: input)
            var tempPlaces = [Place]()
            
            for str in result.recommendations {
                let score = result.scores[str] ?? 0
                tempPlaces.append(Place(name: "\(str)", score: score))
            }
            self.places = tempPlaces
            
        } catch(let error) {
            print("error is \(error.localizedDescription)")
        }
        
    }
}

struct Place: Identifiable {
    public var id = UUID()
    public var name: String
    public var score: Double
}
