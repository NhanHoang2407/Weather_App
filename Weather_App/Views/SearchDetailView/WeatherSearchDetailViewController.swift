//
//  WeatherSearchDetailViewController.swift
//  Weather_App
//
//  Created by Nhan Hoang on 11/4/25.
//

import UIKit

protocol WeatherSearchDetailViewControllerDelegate: AnyObject {
    func viewController(_ viewController: UIViewController, didSelectLocation location: String, completion: @escaping (Bool)->Void)
}

class WeatherSearchDetailViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBarContainer: UIView!
    
    var workItem: DispatchWorkItem?
    private var locationArray: [GeoInfo] = []
    weak var delegate: WeatherSearchDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setupStyle()
        addNotificationObserver()
        searchTextField.becomeFirstResponder()
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWidthShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWidthHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupStyle() {
        searchBarContainer.layer.cornerRadius = 17
    }
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @objc func keyboardWidthShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let bottomInset = keyboardFrame.height
        UIView.animate(withDuration: duration) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.contentInset.bottom = bottomInset
            weakSelf.tableView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    @objc func keyboardWidthHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.tableView.contentInset.bottom = 0
            weakSelf.tableView.verticalScrollIndicatorInsets.bottom = 0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        workItem?.cancel()
        
        let newWorkItem = DispatchWorkItem { [weak self] in
            guard let weakSelf = self,
                  let location = weakSelf.searchTextField.text else { return }
            let request = LocationRequest(parameters: ["q": location, "maxRows": 10, "username": API.locationURLUsername])
            WeatherService.shared().execute(request: request, type: LocationResponse.self) { result in
                switch result {
                case .success(let model):
                    weakSelf.locationArray.removeAll()
                    weakSelf.locationArray.append(contentsOf: model.geonames)
                    DispatchQueue.main.async {
                        weakSelf.tableView.reloadData()
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
        
        workItem = newWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: newWorkItem)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("SearchDetail: deinit")
    }
}

extension WeatherSearchDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let locationString = locationArray[indexPath.row].name
        delegate?.viewController(self, didSelectLocation: locationString) { [weak self] isLocationFetched in
            guard let weakSelf = self else { return }
            if isLocationFetched {
                weakSelf.dismiss(animated: true)
            }
            else {
                weakSelf.view.makeToast("Location does not exist", duration: 1.0, position: .bottom)
                print("Location does not exit.")
            }
        }
    }
}

extension WeatherSearchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath)
        cell.textLabel?.text = "\(locationArray[indexPath.row].name), \(locationArray[indexPath.row].countryName)"
        return cell
    }
    
    
}
