//
//  WeatherMainScreenViewController.swift
//  Weather_App
//
//  Created by Nhan Hoang on 8/4/25.
//

import UIKit

class WeatherMainScreenViewController: UIViewController {
    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    @IBOutlet weak var windIndex: UILabel!
    @IBOutlet weak var humidityIndex: UILabel!
    @IBOutlet weak var feelsLikeIndex: UILabel!

    @IBOutlet weak var weatherTimeLineCollectionView: UICollectionView!
    @IBOutlet weak var mainContentContainer: UIView!
    @IBOutlet weak var subContentContainer: UIView!
    @IBOutlet weak var weatherTimeLineContainer: UIView!

    private let weatherResponse: WeatherResponse
    private let weatherType: WeatherType
    
    private var forecastResponseArray: [WeatherAtSpecificTime] = []
    
    init(weatherResponse: WeatherResponse, weatherType: WeatherType) {
        self.weatherResponse = weatherResponse
        self.weatherType = weatherType
        super.init(nibName: "WeatherMainScreenViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupStyle()
        setUpContent()
        fetchForecastWeather()
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
        
        mainContainer.backgroundColor = weatherType.mainColor
    }
    
    private func setUpContent() {
        cityTitle.text = weatherResponse.name
        weatherIcon.image = weatherType.weatherIcon
        weatherTemp.text = "\(Int(weatherResponse.main.temp.rounded()))°C"
        weatherDescription.text = weatherResponse.weather[0].description
        
        // date format
        let date = Date(timeIntervalSince1970: weatherResponse.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMM"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "vi_VN")
        let formattedDate = dateFormatter.string(from: date)
        currentDate.text = formattedDate
        
        // sub content
        feelsLikeIndex.text = "\(Int(weatherResponse.main.feels_like.rounded()))°C"
        windIndex.text = "\(Int(weatherResponse.wind.speed.rounded())) m/s"
        humidityIndex.text = "\(weatherResponse.main.humidity)%"
    }
    
    private func fetchForecastWeather() {
        let request = WeatherRequest(endPoint: .forecast, parameters: ["q": weatherResponse.name, "appid": API.apiKey, "units": "metric", "cnt": 8])
        WeatherService.shared().execute(request: request, type: ForecastResponse.self) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let model):
                weakSelf.forecastResponseArray.append(contentsOf: model.list)
                DispatchQueue.main.async {
                    weakSelf.weatherTimeLineCollectionView.reloadData()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    deinit {
        print("MainScreen deinit")
    }
}

extension WeatherMainScreenViewController: UICollectionViewDelegate {
    
}

extension WeatherMainScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastResponseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherTimeLineCollectionViewCell.cellIdentifier, for: indexPath) as! WeatherTimeLineCollectionViewCell
        let targetWeatherInfo = forecastResponseArray[indexPath.row]
        cell.configure(weatherInfo: targetWeatherInfo)
        return cell
    }
}

extension WeatherMainScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 87)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}

