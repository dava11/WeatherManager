//
//  WeatherTableViewCell.swift
//  WeatheerManager
//
//  Created by David Khachidze on 22.09.2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    var tempLabel = UILabel()
    var dateLabel = UILabel()
    
    func weatherCell(tempText: String, dateText: String) {
        
        tempLabel.text = tempText
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        tempLabel.backgroundColor = .clear
        tempLabel.textColor = .black
        addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
        }
        
        dateLabel.text = dateText
        dateLabel.font = UIFont.systemFont(ofSize: 20)
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .black
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
    }

}
