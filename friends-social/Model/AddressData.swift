//
//  AddressData.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/13/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation

final class AddressData: ObservableObject {
    @Published var addressData: [Address] = Utils.load("addressesData.json")
}
