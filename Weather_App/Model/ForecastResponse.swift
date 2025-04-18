//
//  ForecastResponse.swift
//  Weather_App
//
//  Created by Nhan Hoang on 18/4/25.
//

import Foundation
import UIKit

struct ForecastResponse: Decodable {
    let list: [WeatherAtSpecificTime]
}
struct WeatherAtSpecificTime: Decodable {
    let dt: TimeInterval
    let main: MainWeatherInfor
    let weather: [Weather]
    let dt_txt: String
    
}

