//
//  Place.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/21/20.
//

import Foundation
struct Place: Decodable, Hashable {
    let id:Int
    let name, thumbnail: String
}
