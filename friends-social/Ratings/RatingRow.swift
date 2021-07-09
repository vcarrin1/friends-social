//
//  RatingView.swift
//  friends-social
//
//  Created by Valentina Carrington on 1/6/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import SwiftUI
import CoreData

struct RatingRow: View {
    
    @State private var place: String
    @State private var rating: Int16 = 0
    @Environment(\.managedObjectContext) var context

    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    var offColor = Color.gray
    var onColor = Color.yellow
    
    // Fetch rating from core data
    var fetchRequest: FetchRequest<Rating>
    var ratingSet: FetchedResults<Rating>{ fetchRequest.wrappedValue }
    
    
    init(place: String) {
        fetchRequest = FetchRequest<Rating>(entity: Rating.entity(),
        sortDescriptors: [], predicate: NSPredicate(format: "place == %@", place))
        _place = State(initialValue: place)
    }
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
           
            ForEach(1..<maximumRating + 1) { number in
                let int16Num = Int16(number)
                self.image(for: int16Num)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        self.rating = int16Num
                        if ratingSet.last?.rating == nil {
                            let rate = Rating(context: context)
                            rate.place = self.place
                            rate.rating = int16Num
                            try! self.context.save()
                        } else {
                            context.performAndWait {
                                ratingSet.last?.rating = int16Num
                                try? context.save()
                            }
                        }
                    }
            }.onAppear {
                self.rating = ratingSet.last?.rating ?? Int16(0)
            }
        }
    }
    
    func image(for number: Int16) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    func setRating(rating: Int16) {
        self.rating = rating
    }
}

struct RatingRow_Previews: PreviewProvider {
    static var previews: some View {
        RatingRow(place: "Huston")
    }
}
