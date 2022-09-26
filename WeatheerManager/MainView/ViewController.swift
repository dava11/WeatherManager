//
//  ViewController.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var dataSource = (UserDefaults.standard.object(forKey: "dataSource") as? [Double]) ?? [] {
        didSet{
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
            UserDefaults.standard.set(dataSource, forKey: "dataSource")
        }
    }
    var dateArray = [String]()
    var date = Date()
    let dateFormater = DateFormatter()
    var dateLabel = UILabel()
    var cityLabel = UILabel()
    var temperatureLabel = UILabel() 
    var cityButton = UIButton()
    var weatherTableView = UITableView()
    let identifire = "Cell"
    var singleCity = SingleCity() {
        didSet{
            DispatchQueue.main.async {
                if let temp = self.singleCity.temp{
                    self.temperatureLabel.text = String(Int(temp))+"°"
                }
                self.cityLabel.text = self.singleCity.city
            }
            self.singleCity.saveData()
        }
    }
    let networkCurrentWeather = NetworkWeather()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        singleCity = SingleCity.getData()
        loadData("Kiev")
        createMainView()
        createWeatherTableView()
        networkCurrentWeather.futureCurrentWeather(forCity: "Kiev") { [weak self] weather in
            guard let self = self else { return }
            self.dataSource = weather.list.map{$0.temp.day}
        }
        createDateArray()
        
        
        

    }
    
    func createMainView() {
        
        view.backgroundColor = .gray
        
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        cityLabel.backgroundColor = .clear
        cityLabel.textColor = .black
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
        dateFormater.dateFormat = "EEEE"
        let weekday = dateFormater.string(from: date)
        dateLabel.text = "\(weekday)"
        dateLabel.textColor = .black
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.backgroundColor = .clear
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.font = UIFont.systemFont(ofSize: 40)
        temperatureLabel.backgroundColor = .clear
        temperatureLabel.textColor = .black
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
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
    
    fileprivate func loadData(_ cityName: String) {
        self.networkCurrentWeather.fetchCurrentWeather(forCity: cityName) { weather in
            self.singleCity = SingleCity(city: weather.name, temp: weather.main.temp)
        }
    }
    
    @objc func cityButtonTap() {
        
        presentAlertController(withTitle: "Enter city Name", message: nil, style: .alert) { cityName in
            self.loadData(cityName)
            self.networkCurrentWeather.futureCurrentWeather(forCity: cityName) { [weak self] weather in
                guard let self = self else { return }
                self.dataSource = weather.list.map{$0.temp.day}
            }
        }
    }
    
    func createWeatherTableView() {
        
        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: identifire)
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        view.addSubview(weatherTableView)
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(cityButton.snp.bottom).offset(10)
            make.bottom.leading.trailing.equalToSuperview().inset(0)
        }
        
    }
    
    func createDateArray() {
        
        var oneDayTime = TimeInterval()
        oneDayTime = 60 * 60 * 24
        for _ in 0..<7 {
            
            date += oneDayTime
            dateFormater.dateFormat = "EEEE"
            let weekday = dateFormater.string(from: date)
            dateArray.append(weekday)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = weatherTableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath) as? WeatherTableViewCell else { return UITableViewCell() }
        
        cell.weatherCell(tempText: "\(Int(dataSource[indexPath.row]))°", dateText: dateArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }


}

