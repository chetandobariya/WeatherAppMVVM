//
//  HourlyWeather.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct HourlyWeather: Identifiable {
    let id = UUID()
    let currentTime: Date?
    let temperature: Double?
    let humidity: Double?
    let uvi: Double?
    let clouds: Double?
    let weather: [Weather]?
}

extension HourlyWeather: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case dt, temp, feels_like, humidity, uvi, clouds, weather
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.currentTime = (try? values.decode(Date.self, forKey: .dt))
        self.temperature = (try? values.decode(Double.self, forKey: .temp))
        self.humidity = (try? values.decode(Double.self, forKey: .humidity))
        self.uvi = (try? values.decode(Double.self, forKey: .uvi))
        self.clouds = (try? values.decode(Double.self, forKey: .clouds))
        self.weather = (try? values.decode([Weather].self, forKey: .weather))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.currentTime, forKey: .dt)
        try container.encode(self.temperature, forKey: .temp)
        try container.encode(self.humidity, forKey: .humidity)
        try container.encode(self.uvi, forKey: .uvi)
        try container.encode(self.clouds, forKey: .clouds)
        try container.encode(self.weather, forKey: .weather)

    }

}
