//
//  WeatherLocationTableViewCell.swift
//  Weather_App
//
//  Created by Nhan Hoang on 8/4/25.
//

import UIKit

class WeatherLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "WeatherLocationTableViewCell"

    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var locationNameTitle: UILabel!
    @IBOutlet weak var locationCurrentWeatherDescription: UILabel!
    @IBOutlet weak var locationCurrentTemp: UILabel!
    @IBOutlet weak var locationWeatherIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.locationNameTitle.text = nil
        self.locationCurrentWeatherDescription.text = nil
        self.locationCurrentTemp.text = nil
        self.locationWeatherIcon.image = nil
    }
    
    // MARK: Private Function
    
    private func setupStyle() {
        contentContainer.layer.cornerRadius = 32
    }
    
    // MARK: Public Function
    
    func configure(location city: WeatherResponse, weatherType: WeatherType?) {
        guard let weatherType = weatherType else { return }
        self.contentContainer.backgroundColor = weatherType.mainColor
        self.locationNameTitle.text = city.name
        self.locationCurrentTemp.text = "\(Int(city.main.temp.rounded()))°C"
        self.locationCurrentWeatherDescription.text = city.weather[0].description
        self.locationWeatherIcon.image = weatherType.weatherIcon
    }
}
