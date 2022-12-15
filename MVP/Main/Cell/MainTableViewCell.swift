//
//  MainTableViewCell.swift
//  MVP
//
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    private let dayLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let tempFromLabel = UILabel()
    private let tempToLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(forecast: Weather.DayForecast) {
        dayLabel.text = forecast.day
        weatherImageView.image = forecast.picture
        tempFromLabel.text = forecast.tempFrom
        tempToLabel.text = forecast.tempTo
    }
}

// MARK: - Configure
private extension MainTableViewCell {
    func setupUI() {
        setupViews()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = .clear
        dayLabel.textColor = .white
        dayLabel.font = UIFont(name: "Inter", size: 18)
        
        tempFromLabel.textColor = UIColor(red: 0.584, green: 0.631, blue: 0.694, alpha: 1)
        tempFromLabel.font = UIFont(name: "Inter", size: 16)
        
        tempToLabel.textColor = .white
        tempToLabel.font = UIFont(name: "Inter", size: 16)
    }
    
    func setupViewHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(weatherImageView)
        contentView.addSubview(tempFromLabel)
        contentView.addSubview(tempToLabel)
    }
    
    func setupConstraints() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        tempFromLabel.translatesAutoresizingMaskIntoConstraints = false
        tempToLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -200),
            
            tempFromLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempFromLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110),
            
            tempToLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            tempToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14),
        ])
    }
}
