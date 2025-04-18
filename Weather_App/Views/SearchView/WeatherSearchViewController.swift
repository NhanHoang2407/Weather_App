//
//  ViewController.swift
//  Weather_App
//
//  Created by Nhan Hoang on 8/4/25.
//

import UIKit

class WeatherSearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var locationTableView: UITableView!
    @IBOutlet weak var searchBarContainer: UIView!
    
    private var locationArray: [WeatherResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setUpTableView()
        setupStyle()
    }

    private func setUpTableView() {
        let locationCell = UINib(nibName: "WeatherLocationTableViewCell", bundle: nil)
        locationTableView.register(locationCell, forCellReuseIdentifier: WeatherLocationTableViewCell.cellIdentifier)
        locationTableView.dataSource = self
        locationTableView.delegate = self
    }
    
    private func setupStyle() {
        locationTableView.separatorStyle = .none
        locationTableView.showsVerticalScrollIndicator = false
        locationTableView.layer.cornerRadius = 32
        searchBarContainer.layer.cornerRadius = 17
    }
}

extension WeatherSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let targetLocation = locationArray[indexPath.row]
        let weatherType = WeatherType(rawValue: targetLocation.weather.first!.main)
        let mainVC = WeatherMainScreenViewController(weatherResponse: targetLocation, weatherType: weatherType!)
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

extension WeatherSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherLocationTableViewCell.cellIdentifier, for: indexPath) as! WeatherLocationTableViewCell
        let targetLocation = locationArray[indexPath.row]
        let weatherType = WeatherType(rawValue: targetLocation.weather.first!.main)
        cell.selectionStyle = .none
        cell.configure(location: targetLocation, weatherType: weatherType)
        return cell
    }
}

extension WeatherSearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let searchDetailVC = WeatherSearchDetailViewController()
        searchDetailVC.delegate = self
        present(searchDetailVC, animated: true)
    }
}

extension WeatherSearchViewController: WeatherSearchDetailViewControllerDelegate {

    func viewController(_ viewController: UIViewController, didSelectLocation location: String, completion: @escaping (Bool) -> Void) {
        let request = WeatherRequest(endPoint: .weather, parameters: ["q": location, "appid": API.apiKey, "units": "metric", "lang": "vi"])
        WeatherService.shared().execute(request: request, type: WeatherResponse.self) { [weak self] result in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let model):
                weakSelf.locationTableView.performBatchUpdates {
                    weakSelf.locationArray.append(model)
                    let targetIndexPath = IndexPath(item: (weakSelf.locationArray.count - 1), section: 0)
                    weakSelf.locationTableView.insertRows(at: [targetIndexPath], with: .top)
                }
                completion(true)
            case .failure(let failure):
                print(String(describing: failure))
                completion(false)
            }
        }
    }
}
