//
//  Weather.swift
//  Weather_App
//
//  Created by Nhan Hoang on 10/4/25.
//
import UIKit

struct WeatherResponse: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: MainWeatherInfor
    let wind: WindInfor
    let clouds: CloudInfor
    let dt: TimeInterval
    let name: String
}

struct Coordinate: Decodable {
    let lon: Double
    let lat: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeatherInfor: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct WindInfor: Decodable {
    let speed: Double
    let deg: Int
}

struct CloudInfor: Decodable {
    let all: Int
}

// MARK: Weather Type

enum WeatherType: String {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case drizzle = "Drizzle"
    case thunderstorm = "Thunderstorm"
    case snow = "Snow"
    case mist = "Mist"
    case fog = "Fog"
    case haze = "Haze"
    case smoke = "Smoke"
    case dust = "Dust"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    
    var weatherIcon: UIImage? {
        switch self {
        case .clear:
            return UIImage(named: "Sunny")
        case .clouds, .mist, .fog, .haze, .smoke, .dust, .sand, .ash, .squall, .tornado:
            return UIImage(named: "Clear")
        case .rain, .drizzle, .thunderstorm:
            return UIImage(named: "Rain")
        case .snow:
            return UIImage(named: "Snow")
        }
    }
    
    var mainColor: UIColor? {
        switch self {
        case .clear:
            return UIColor(hex: "EDBC19")
        case .clouds, .mist, .fog, .haze, .smoke, .dust, .sand, .ash, .squall, .tornado:
            return UIColor(hex: "5CB5FE")
        case .rain, .drizzle, .thunderstorm:
            return UIColor(hex: "687D91")
        case .snow:
            return UIColor(hex: "16BEF5")
        }
    }
}

// MARK: HEX convertion UIColor
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let length = hexSanitized.count
        
        let r, g, b, a: CGFloat
        switch length {
        case 6: // RGB (FFCC00)
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255
            b = CGFloat(rgb & 0x0000FF) / 255
            a = 1.0
        case 8: // ARGB (FF00CCFF)
            a = CGFloat((rgb & 0xFF000000) >> 24) / 255
            r = CGFloat((rgb & 0x00FF0000) >> 16) / 255
            g = CGFloat((rgb & 0x0000FF00) >> 8) / 255
            b = CGFloat(rgb & 0x000000FF) / 255
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
