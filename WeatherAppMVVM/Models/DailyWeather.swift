//
//  DailyWeather.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct DailyWeather: Identifiable {
    let id = UUID()
    let currentTime: Date?
    let humidity: Double?
    let clouds: Double?
    let temperature: DailyTemperature?
    let weather: [Weather]?
}

extension DailyWeather: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case dt, temp, weather, humidity, clouds
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.currentTime = (try? values.decode(Date.self, forKey: .dt))
        self.temperature = (try? values.decode(DailyTemperature.self, forKey: .temp))
        self.weather = (try? values.decode([Weather].self, forKey: .weather))
        self.humidity = (try? values.decode(Double.self, forKey: .humidity))
        self.clouds = (try? values.decode(Double.self, forKey: .clouds))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.currentTime, forKey: .dt)
        try container.encode(self.temperature, forKey: .temp)
        try container.encode(self.weather, forKey: .weather)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.clouds, forKey: .clouds)
    }

}

struct DailyTemperature {
    let day: Double?
    let min: Double?
    let max: Double?
}

extension DailyTemperature: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case day, min, max
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.day = (try? values.decode(Double.self, forKey: .day))
        self.min = (try? values.decode(Double.self, forKey: .min))
        self.max = (try? values.decode(Double.self, forKey: .max))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.day, forKey: .day)
        try container.encode(self.min, forKey: .min)
        try container.encode(self.max, forKey: .max)
    }

}
