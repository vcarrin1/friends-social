//
//  Utils.swift
//  friends-social
//
//  Created by Valentina Carrington on 12/13/20.
//  Copyright © 2020 Valentina Carrington. All rights reserved.
//

import Foundation
import SwiftUI

class Utils {
    
    static func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    static func calculateOffset(condition: Bool, tapped: Bool) -> CGFloat {
        if condition && !tapped {
            return UIScreen.main.bounds.size.height - UIScreen.main.bounds.size.height / 4
        } else if tapped {
            return 100
        } else {
            return UIScreen.main.bounds.size.height
        }
    }
}
