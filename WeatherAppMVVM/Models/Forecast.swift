//
//  Forecast.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct Forecast {
    var lat: Double?
    var lon: Double?
    var timezone: String?
    var current: CurrentWeather?
    var hourly: [HourlyWeather]?
    var daily: [DailyWeather]?
    var alerts: [WeatherAlert]?

}

extension Forecast: Codable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case lat, lon, timezone, current, hourly, daily, alerts
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.lat = (try? values.decode(Double.self, forKey: .lat))
        self.lon = (try? values.decode(Double.self, forKey: .lon))
        self.timezone = (try? values.decode(String.self, forKey: .timezone))
        self.current = (try? values.decode(CurrentWeather.self, forKey: .current))
        self.hourly = (try? values.decode([HourlyWeather].self, forKey: .hourly))
        self.daily = (try? values.decode([DailyWeather].self, forKey: .daily))
        self.alerts = (try? values.decode([WeatherAlert].self, forKey: .alerts))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.lat, forKey: .lat)
        try container.encode(self.lon, forKey: .lon)
        try container.encode(self.timezone, forKey: .timezone)
        try container.encode(self.current, forKey: .current)
        try container.encode(self.hourly, forKey: .hourly)
        try container.encode(self.daily, forKey: .daily)
        try container.encode(self.alerts, forKey: .alerts)
    }
}
