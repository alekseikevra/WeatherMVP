//
//  TitleTableViewCell.swift
//  MVP
//
//  Created by Aleksei Kevra on 23.11.22.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {
   
    private let titleLabel = UILabel()
    private let calendarImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TitleTableViewCell {
    
    func setupUI() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(calendarImageView)
        contentView.addSubview(titleLabel)
        
        calendarImageView.image = UIImage(named: "calendar")
        titleLabel.text = "10-DAY FORECAST"
        titleLabel.textColor = UIColor(red: 0.584, green: 0.631, blue: 0.694, alpha: 1)
        titleLabel.font = UIFont(name: "Inter", size: 14)
    }
    
    func setupConstraints() {
        calendarImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            calendarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            calendarImageView.heightAnchor.constraint(equalToConstant: 12),
            calendarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            calendarImageView.widthAnchor.constraint(equalToConstant: 12),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
}
