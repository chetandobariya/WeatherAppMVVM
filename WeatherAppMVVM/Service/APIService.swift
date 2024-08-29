//
//  APIService.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchWeather(lat: Double, lon: Double, excluded: String) -> AnyPublisher<Forecast, Error>
    func fetchCity(lat: Double, lon: Double) -> AnyPublisher<[City], Error>
}

class APIService: APIServiceProtocol {
    
    
    func fetchWeather(lat: Double, lon: Double, excluded: String) -> AnyPublisher<Forecast, Error> {
        guard var urlComponents = URLComponents(string: Constants.AppURL.baseUrl.absoluteString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "lat", value: "\(lat)"))
        queryItems.append(URLQueryItem(name: "lon", value: "\(lon)"))
        queryItems.append(URLQueryItem(name: "excluded", value: excluded))
        queryItems.append(URLQueryItem(name: "units", value: "imperial"))
        queryItems.append(URLQueryItem(name: "appid", value: Constants.AppSettings.apiKey))
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Forecast.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCity(lat: Double, lon: Double) -> AnyPublisher<[City], Error> {
        guard var urlComponents = URLComponents(string: Constants.AppURL.geoURL.absoluteString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "lat", value: "\(lat)"))
        queryItems.append(URLQueryItem(name: "lon", value: "\(lon)"))
        queryItems.append(URLQueryItem(name: "appid", value: Constants.AppSettings.apiKey))
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [City].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
