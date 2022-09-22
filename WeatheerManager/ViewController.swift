//
//  ViewController.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var cityLabel = UILabel()
    var temperatureLabel = UILabel()
    var cityButton = UIButton()
    let networkWeather = NetworkWeather()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMainView()

    }
    
    func createMainView() {
        
        cityLabel.text = "Kiev"
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.backgroundColor = .clear
        cityLabel.textColor = .black
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        temperatureLabel.text = "30°"
        temperatureLabel.font = UIFont.systemFont(ofSize: 40)
        temperatureLabel.backgroundColor = .clear
        temperatureLabel.textColor = .black
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
        }
        
        cityButton.backgroundColor = .black
        cityButton.setTitle("Add city", for: .normal)
        cityButton.addTarget(self, action: #selector(cityButtonTap), for: .touchUpInside)
        cityButton.layer.cornerRadius = 10
        view.addSubview(cityButton)
        cityButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(temperatureLabel.snp.bottom).offset(10)
        }

    }
    
    @objc func cityButtonTap() {
        
        presentAlertController(withTitle: "Enter city Name", message: nil, style: .alert) { cityName in
            self.networkWeather.fetchCurrentWeather(forCity: cityName)
            self.cityLabel.text = cityName
        }
    }


}

