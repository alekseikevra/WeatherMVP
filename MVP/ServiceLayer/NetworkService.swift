//
//  NetworkService.swift
//  MVP
//
//  Created by Aleksei Kevra on 21.11.22.
//

import Foundation

protocol NetworkServiceProtocol {
    func getWeather(completion: @escaping (Result<Weather.WeatherResponse, ErrorModel>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    func getWeather(completion: @escaping (Result<Weather.WeatherResponse, ErrorModel>) -> Void) {
        if let jsonData = getDataFromFile(fileName: "TestTaskJSON") {
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let weatherResponse = try decoder.decode(Weather.WeatherResponse.self, from: jsonData)
                completion(.success(weatherResponse))
            } catch {
                completion(.failure(.init(message: error.localizedDescription)))
            }
        } else {
            completion(.failure(.init(message: "Something went wrong")))
        }
    }

    private func getDataFromFile(fileName: String) -> Data? {
        if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
            let jsonData = try? String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        } else {
            return nil
        }
    }
}

struct ErrorModel: Error {
    let message: String
}
