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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupStyle() {
        contentContainer.layer.cornerRadius = 32
    }
    
}
