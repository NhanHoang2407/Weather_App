//
//  APIRequest.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//

import Foundation

protocol APIRequest {
    var urlString: String { get }
    var parameters: [String: Any] { get }
}

extension APIRequest {
    var url: URL? {
        var components = URLComponents(string: urlString)
        components?.queryItems = parameters.map({ parameter in
            return URLQueryItem(name: parameter.key, value: "\(parameter.value)")
        })
        return components?.url
    }
}
