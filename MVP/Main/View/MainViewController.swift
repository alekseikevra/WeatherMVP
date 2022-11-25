//
//  ViewController.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: ErrorModel)
    func setupCity(_ city: Weather.City)
}

final class MainViewController: UIViewController {
    // MARK: - UI
    private let backgroundImageView = UIImageView()
    private let cityLabel = UILabel()
    private let nowWeatherLabel = UILabel()
    private let weatherPerDayView = UIView()
    private let separatorView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 14, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    private let tableView = UITableView()
    private let descriptionLabel = UILabel()
    
    // - MARK: Dependencies
    private let presenter: MainViewPresenterProtocol
    
    init(presenter: MainViewPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.onViewDidLoad()
    }
    
    func setupCity(_ city: Weather.City) {
        cityLabel.text = city.name
        nowWeatherLabel.text = city.currentWeather
        descriptionLabel.text = city.description
    }
}

//MARK: - CollectionView Delegate, DataSource, FlowLayOut
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter.hourForecasts[indexPath.item].itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter.hourForecastsMinimumInterSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.hourForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hourForecast = presenter.hourForecasts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCellIdentifier, for: indexPath) as! MainCollectionViewCell
        cell.setup(weatherPerDay: hourForecast)
        return cell
    }
}

//MARK: - TableView DataSource
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        46
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.forecasts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.titleCellIdentifier, for: indexPath) as! TitleTableViewCell
            cell.selectionStyle = .none
            return cell
        }
        let forecast = presenter.forecasts[indexPath.row - 1]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MainTableViewCell
        cell.setup(forecast: forecast)
        cell.selectionStyle = .none
        return cell
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    func failure(error: ErrorModel) {
        print(error.message)
    }
}

// MARK: - Configure
private extension MainViewController {
    func setupUI() {
        setupView()
        setupCollectionView()
        setupTableView()
        setupViewHierarchy()
        setupConstraints()
    }
    
    func setupView() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = UIView.ContentMode.scaleAspectFill
        
        cityLabel.font = UIFont(name: "Inter", size: 30)
        cityLabel.textColor = .white
        
        descriptionLabel.font = UIFont(name: "Inter", size: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        
        nowWeatherLabel.alpha = 0.6
        nowWeatherLabel.font = UIFont(name: "Inter", size: 16)
        nowWeatherLabel.textColor = .white
        
        weatherPerDayView.backgroundColor = UIColor(red: 0.236, green: 0.304, blue: 0.396, alpha: 0.6)
        weatherPerDayView.layer.cornerRadius = 14
        
        separatorView.backgroundColor = UIColor(red: 0.43, green: 0.472, blue: 0.529, alpha: 1)
    }
    
    func setupCollectionView() {
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupTableView() {
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: Constants.titleCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor(red: 0.236, green: 0.304, blue: 0.396, alpha: 0.6)
        tableView.layer.cornerRadius = 14
        tableView.separatorInset = .init(top: 0, left: 14, bottom: 0, right: 14)
        tableView.separatorColor = UIColor(red: 0.43, green: 0.472, blue: 0.529, alpha: 1)
    }
    
    func setupViewHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(cityLabel)
        view.addSubview(nowWeatherLabel)
        view.addSubview(weatherPerDayView)
        weatherPerDayView.addSubview(descriptionLabel)
        weatherPerDayView.addSubview(separatorView)
        weatherPerDayView.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        nowWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherPerDayView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nowWeatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            nowWeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherPerDayView.topAnchor.constraint(equalTo: nowWeatherLabel.bottomAnchor, constant: 60),
            weatherPerDayView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            weatherPerDayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherPerDayView.heightAnchor.constraint(equalToConstant: 180),
            
            descriptionLabel.topAnchor.constraint(equalTo: weatherPerDayView.topAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: weatherPerDayView.leadingAnchor, constant: 14),
            descriptionLabel.trailingAnchor.constraint(equalTo: weatherPerDayView.trailingAnchor, constant: -40),
            
            separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14),
            separatorView.leadingAnchor.constraint(equalTo: weatherPerDayView.leadingAnchor, constant: 14),
            separatorView.centerXAnchor.constraint(equalTo: weatherPerDayView.centerXAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            collectionView.topAnchor.constraint(equalTo: weatherPerDayView.topAnchor, constant: 76),
            collectionView.leadingAnchor.constraint(equalTo: weatherPerDayView.leadingAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: weatherPerDayView.centerXAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 110),
            
            tableView.topAnchor.constraint(equalTo: weatherPerDayView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 491)
        ])
    }
    
    enum Constants {
        static let cellIdentifier = "MainTableViewCell"
        static let titleCellIdentifier = "TitleTableViewCell"
        static let collectionViewCellIdentifier = "MainCollectionViewCell"
    }
}
