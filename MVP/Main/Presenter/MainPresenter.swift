//
//  MainPresenter.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import UIKit

protocol MainViewPresenterProtocol: AnyObject {
    var forecasts: [Weather.DayForecast] { get }
    var hourForecasts: [Weather.HourForecast] { get }
    var hourForecastsMinimumInterSpacing: CGFloat { get }
    func onViewDidLoad()
}

final class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    private let networkService: NetworkServiceProtocol
    var forecasts: [Weather.DayForecast] = []
    var hourForecasts: [Weather.HourForecast] = []
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        getWeather()
    }
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter
    }()
    
    func onViewDidLoad() {
        getWeather()
    }
    
    var hourForecastsMinimumInterSpacing: CGFloat {
        var itemsTotalWidth: CGFloat = 14
        for hourForecast in hourForecasts {
            itemsTotalWidth += hourForecast.itemSize.width
        }
        
        let spacing = (UIScreen.main.bounds.width - itemsTotalWidth - 48) / CGFloat(hourForecasts.count)
        return spacing
    }
    
    private func getWeather() {
        networkService.getWeather { [weak self] result in
            switch result {
            case .success(let response):
                self?.handleCity(response)
                self?.handleForecasts(response.forecasts)
                self?.handleHourForecast(response.weatherPerDays)
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    private func handleForecasts(_ forecasts: [Weather.Forecast]) {
        var dayForecasts = [Weather.DayForecast]()
        
        for i in 0..<forecasts.count {
            let forecast = forecasts[i]
            var day = dateFormatter.string(from: forecast.date)
            var picture: UIImage?
            let tempFrom: String
            let tempTo: String
            
            if i == 0 {
                day = "Сегодня"
            } else {
                day = dateFormatter.string(from: forecast.date)
            }
            tempFrom = forecast.minTemperature.description + "°"
            tempTo = forecast.maxTemperature.description + "°"
            
            switch forecast.weatherType {
            case .cloudy:
                picture = .init(named: "cloudy")
            case .snowily:
                picture = .init(named: "snowily")
            }
            
            
            let dayForecast = Weather.DayForecast(day: day, picture: picture, tempFrom: tempFrom, tempTo: tempTo)
            dayForecasts.append(dayForecast)
        }
        
        self.forecasts = dayForecasts
        view?.success()
    }
    
    private func handleHourForecast(_ weatherPerDays: [Weather.WeatherPerDay]) {
        var hourForecast = [Weather.HourForecast]()
        
        for i in 0..<weatherPerDays.count {
            let weatherPerDay = weatherPerDays[i]
            var picture: UIImage?
            let hourText: String
            let tempText: String
            let itemSize: CGSize
            
            if weatherPerDay.sunset == true {
                picture = .init(named: "sunset")
                hourText = weatherPerDay.timestamp
                tempText = "Заход солнца"
                itemSize = .init(width: 145, height: 110)
            } else {
                if i == 0 {
                    hourText = "Сегодня"
                    itemSize = .init(width: 60, height: 110)
                } else {
                    hourText = weatherPerDay.timestamp
                    itemSize = .init(width: 50, height: 110)
                }
                tempText = weatherPerDay.temperature + "°"
                
                switch weatherPerDay.weatherType {
                case .cloudy:
                    picture = .init(named: "cloudy")
                case .snowily:
                    picture = .init(named: "snowily")
                }
            }
            
            let dayForecast = Weather.HourForecast(hour: hourText, picture: picture, temp: tempText, itemSize: itemSize)
            hourForecast.append(dayForecast)
        }
        
        self.hourForecasts = hourForecast
        view?.success()
    }
    
    private func handleCity(_ response: Weather.WeatherResponse) {
        let city = Weather.City(name: response.city, currentWeather: response.temperature, description: response.description)
        view?.setupCity(city)
    }
}
