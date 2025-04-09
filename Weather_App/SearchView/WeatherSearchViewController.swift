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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupStyle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let mainvc = WeatherMainScreenViewController()
            if let nav = self.navigationController {
                nav.pushViewController(mainvc, animated: true)
            } else {
                print("not printed")
            }
        }
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
    
}

extension WeatherSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherLocationTableViewCell.cellIdentifier, for: indexPath) as! WeatherLocationTableViewCell
        return cell
    }
    
    
}
