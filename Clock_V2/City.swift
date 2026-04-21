//
//  City.swift
//  Clock_V2
//
//  Created by Aarief Fawwaz Satriahutama on 21/04/26.
//

import Foundation
import SwiftData

@Model
final class City {
    var id: String
    var name: String
    var country: String
    var countryCode: String
    
    init(id: String, name: String, country: String, countryCode: String) {
        self.id = id
        self.name = name
        self.country = country
        self.countryCode = countryCode
    }
}
