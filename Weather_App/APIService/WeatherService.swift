//
//  WeatherService.swift
//  Weather_App
//
//  Created by Nhan Hoang on 10/4/25.
//

import Foundation
import Alamofire

class WeatherService {
    private static let weatherService = WeatherService()
    private let cacheManager: CacheManager = CacheManager()
    
    private init() {}
    
    class func shared() -> WeatherService {
        return weatherService
    }
    
    func execute<T:Decodable>(request: APIRequest, type: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        if let cachedData = cacheManager.cacheObject(forKey: request.url) {
            do {
                let result = try JSONDecoder().decode(T.self, from: cachedData)
                completion(.success(result))
            }
            catch {
                print("Decode failed")
                completion(.failure(error))
            }
            return
        }
                    
        AF.request(request.urlString, parameters: request.parameters).response { [weak self] response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    self?.cacheManager.setObject(data, url: response.request?.url)
                    completion(.success(result))
                }
                catch {
                    print("Decode failed")
                    completion(.failure(error))
                }
            }
            else if let error = response.error {
                print("Looix: \(error)")
            }
        }
    }
}
