//
//  WeatherTimeLineCollectionViewCell.swift
//  Weather_App
//
//  Created by Nhan Hoang on 9/4/25.
//

import UIKit

class WeatherTimeLineCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "WeatherTimeLineCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: "WeatherTimeLineCollectionViewCell", bundle: nil)
    }
}
