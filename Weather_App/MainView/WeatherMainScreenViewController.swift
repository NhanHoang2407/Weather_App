//
//  WeatherMainScreenViewController.swift
//  Weather_App
//
//  Created by Nhan Hoang on 8/4/25.
//

import UIKit

class WeatherMainScreenViewController: UIViewController {
    
    @IBOutlet weak var weatherTimeLineCollectionView: UICollectionView!
    @IBOutlet weak var mainContentContainer: UIView!
    @IBOutlet weak var subContentContainer: UIView!
    @IBOutlet weak var weatherTimeLineContainer: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupStyle()
    }

    private func setupCollectionView() {
        weatherTimeLineCollectionView.register(WeatherTimeLineCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherTimeLineCollectionViewCell.cellIdentifier)
        weatherTimeLineCollectionView.delegate = self
        weatherTimeLineCollectionView.dataSource = self
    }
    
    private func setupStyle() {
        mainContentContainer.layer.cornerRadius = 30
        subContentContainer.layer.cornerRadius = 20
        weatherTimeLineContainer.layer.cornerRadius = 20
        
        mainContentContainer.layer.masksToBounds = true
        subContentContainer.layer.masksToBounds = true
        weatherTimeLineContainer.layer.masksToBounds = true

        weatherTimeLineCollectionView.backgroundColor = .clear
        weatherTimeLineCollectionView.showsHorizontalScrollIndicator = false
    }
    
    deinit {
        print("MainScreen deinit")
    }
}

extension WeatherMainScreenViewController: UICollectionViewDelegate {
    
}

extension WeatherMainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as! WeatherTimeLineCollectionViewCell
        return cell
    }
}

extension WeatherMainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 87)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

