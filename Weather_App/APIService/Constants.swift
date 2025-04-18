//
//  Constants.swift
//  Weather_App
//
//  Created by Nhan Hoang on 10/4/25.
//

enum API {
    static let baseWeatherURL = "https://api.openweathermap.org/data/2.5/"
    static let baseLocationURL = "http://api.geonames.org/searchJSON"
    static let locationURLUsername = "noal6426"
    static let apiKey = "ec1419dde56689638ae7dbdb44854fa2"
    static let currentWeatherURL = baseWeatherURL + "weather"
    static let forecastURL = baseWeatherURL + "forecast"
}
