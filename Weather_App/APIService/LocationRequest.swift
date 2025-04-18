//
//  LocationRequest.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//

import Foundation

class LocationRequest: APIRequest {
    let parameters: [String: Any]
    var urlString: String {
        return API.baseLocationURL
    }
    
    init(parameters: [String : Any]) {
        self.parameters = parameters
    }
}
