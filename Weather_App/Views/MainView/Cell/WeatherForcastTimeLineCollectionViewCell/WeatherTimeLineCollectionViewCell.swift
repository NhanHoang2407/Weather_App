//
//  WeatherTimeLineCollectionViewCell.swift
//  Weather_App
//
//  Created by Nhan Hoang on 9/4/25.
//

import UIKit

class WeatherTimeLineCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "WeatherTimeLineCollectionViewCell"
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak  var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public static func nib() -> UINib {
        return UINib(nibName: "WeatherTimeLineCollectionViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timeLabel.text = nil
        weatherIcon.image = nil
        tempLabel.text = nil
    }
    
    public func configure(weatherInfo: WeatherAtSpecificTime) {
        let dt_txt = weatherInfo.dt_txt
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = formatter.date(from: dt_txt) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "H:mm a"
            let hour = hourFormatter.string(from: date)
            timeLabel.text = hour
        }
        
        let weatherType = WeatherType(rawValue: weatherInfo.weather[0].main)
        weatherIcon.image = weatherType?.weatherIcon
        tempLabel.text = "\(Int(weatherInfo.main.temp.rounded()))°"
    }
}
