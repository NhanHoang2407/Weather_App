//
//  LocationResponse.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//

import Foundation
struct LocationResponse: Decodable {
    let geonames: [GeoInfo]
}

struct GeoInfo: Decodable {
    let name: String
    let countryName: String
}
