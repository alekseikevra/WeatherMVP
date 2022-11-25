//
//  MainCollectionViewCell.swift
//  MVP
//
//  Created by Aleksei Kevra on 23.11.22.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private let hourLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let tempLabel = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(weatherPerDay: Weather.HourForecast) {
        hourLabel.text = weatherPerDay.hour
        weatherImageView.image = weatherPerDay.picture
        tempLabel.text = weatherPerDay.temp
    }
}

extension MainCollectionViewCell {
    func setupUI() {
        setupViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupViews() {
        hourLabel.font = UIFont(name: "Inter", size: 14)
        hourLabel.textColor = .white
        hourLabel.textAlignment = .center
        
        tempLabel.font = UIFont(name: "Inter", size: 16)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
        
        contentView.backgroundColor = .clear
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(hourLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(tempLabel)
    }
    
    func setupConstraints() {
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            hourLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

