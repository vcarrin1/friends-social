//
//  RatingPlace.swift
//  friends-social
//
//  Created by Valentina Carrington on 8/4/21.
//  Copyright © 2021 Valentina Carrington. All rights reserved.
//

import Foundation

struct RatingPlace: Encodable {
    var user: String
    var place: String
    var score: Int16
}
