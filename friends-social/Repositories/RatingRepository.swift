//
//  ReviewRepository.swift
//  friends-social
//
//  Created by Valentina Carrington on 8/4/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class RatingRepository: ObservableObject {
  
  private let path: String = "ratings"
  private let store = Firestore.firestore()

  func add(_ rating: RatingPlace) {
    do {
      _ = try store.collection(path).addDocument(from: rating)
    } catch {
      fatalError("Unable to add card: \(error.localizedDescription).")
    }
  }
}
