//
//  WeatherRequest.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//

import Foundation

class WeatherRequest: APIRequest {
    let endPoint: WeatherEndpoint
    let parameters: [String: Any]
    var urlString: String {
        let baseURL = API.baseWeatherURL
        let endPointString = endPoint.rawValue
        return baseURL + endPointString
    }
    
    init(endPoint: WeatherEndpoint, parameters: [String : Any]) {
        self.endPoint = endPoint
        self.parameters = parameters
    }
}

enum WeatherEndpoint: String {
    case weather = "weather"
    case forecast = "forecast"
}
