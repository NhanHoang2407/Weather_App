//
//  CacheManager.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//
import Foundation

class CacheManager {
    private let cacheManager: NSCache<NSString, NSData>

    init() {
        self.cacheManager = NSCache<NSString, NSData>()
    }
    
    func cacheObject(forKey url: URL?) -> Data? {
        guard let url = url else { return nil }
        let urlString = url.absoluteString
        let data = cacheManager.object(forKey: urlString as NSString)
        return data as? Data
    }
    
    func setObject(_ data: Data, url: URL?) {
        guard let url = url else { return }
        let urlString = url.absoluteString
        cacheManager.setObject(data as NSData, forKey: urlString as NSString)
    }
    
}
