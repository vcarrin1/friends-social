//
//  RatingViewModel.swift
//  friends-social
//
//  Created by Valentina Carrington on 8/4/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import Combine

class RatingViewModel: ObservableObject {
  
  @Published var ratingRepository = RatingRepository()

  func add(_ rating: RatingPlace) {
    ratingRepository.add(rating)
  }
}
