//
//  Person.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import UIKit

enum Weather {
    struct WeatherResponse: Decodable {
        let city: String
        let temperature: String
        let description: String
        let weatherPerDays: [WeatherPerDay]
        let forecasts: [Forecast]

        enum CodingKeys: String, CodingKey {
            case city, temperature, description, weatherPerDays = "weather_per_day", forecasts = "forecast"
        }
    }

    struct WeatherPerDay: Decodable {
        let timestamp: String
        let weatherType: WeatherType
        let temperature: String
        let sunset: Bool?
        
        enum CodingKeys: String, CodingKey {
            case timestamp, weatherType = "weather_type", temperature, sunset
        }
    }

    struct Forecast: Decodable {
        let date: Date
        let minTemperature: Int
        let maxTemperature: Int
        let weatherType: WeatherType

        enum CodingKeys: String, CodingKey {
            case date, minTemperature = "min_temperature", maxTemperature = "max_temperature", weatherType = "weather_type"
        }
    }

    enum WeatherType: String, Decodable {
        case cloudy
        case snowily
    }

    struct DayForecast {
        let day: String
        let picture: UIImage?
        let tempFrom: String
        let tempTo: String
    }
    
    struct City {
        let name: String
        let currentWeather: String
        let description: String
    }
    
    struct HourForecast {
        let hour: String
        let picture: UIImage?
        let temp: String
        let itemSize: CGSize
    }
}
