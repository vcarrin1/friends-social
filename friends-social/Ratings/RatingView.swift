//
//  RatingView.swift
//  friends-social
//
//  Created by Valentina Carrington on 1/6/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import SwiftUI

struct RatingView: View {
    @ObservedObject var topRecommendations = Recommender()
    
    var body: some View {
        List(topRecommendations.places) { place in
            HStack () {
                ZStack {
                    Rectangle().fill(Color.white).padding().cornerRadius(20)
                    VStack {
                        Text(place.name)
                        Text("\(place.score)")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                    }
                }.frame(width: 200, height: 70)
                
                VStack {
                    RatingRow(place: place.name)
                }
            }
        }.navigationBarTitle("Reviews")
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
