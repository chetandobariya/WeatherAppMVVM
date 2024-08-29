//
//  DataStub.swift
//  WeatherAppMVVMTests
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

// MARK: Backend samples
func sampleForeCast(lat: Double? = 35.45,
                    lon: Double? = -96.93,
                    timezone: String? = "America/Chicago",
                    current: CurrentWeather? = sampleCurrentWeather(),
                    hourly: [HourlyWeather]? = [sampleHourlyWeather(), sampleHourlyWeather()],
                    daily: [DailyWeather]? = [sampleDailyWeather(), sampleDailyWeather()],
                    alerts: [WeatherAlert]? = [sampleWeatherAlert()]) -> Forecast {
    Forecast(lat: lat,
             lon: lon,
             timezone: timezone,
             current: current,
             hourly: hourly,
             daily: daily,
             alerts: alerts)
}
func sampleCurrentWeather(currentTime: Date? = Date(),
                        temperature: Double? = 45,
                         humidity: Double? = 45,
                        clouds: Double? = 15,
                         uvi: Double? = 12,
                        weather: [Weather]? = [sampleWeather()]) -> CurrentWeather {
    CurrentWeather(currentTime: currentTime,
                  temperature: temperature,
                  humidity: humidity,
                  uvi: uvi,
                  clouds: clouds,
                  weather: weather)
}
func sampleHourlyWeather(currentTime: Date? = Date(),
                        temperature: Double? = 45,
                         humidity: Double? = 45,
                        clouds: Double? = 15,
                         uvi: Double? = 12,
                        weather: [Weather]? = [sampleWeather()]) -> HourlyWeather {
    HourlyWeather(currentTime: currentTime,
                  temperature: temperature,
                  humidity: humidity,
                  uvi: uvi,
                  clouds: clouds,
                  weather: weather)
}

func sampleDailyWeather(currentTime: Date? = Date(),
                        humidity: Double? = 45,
                        clouds: Double? = 15,
                        temperature: DailyTemperature? = sampleDailyTemperature(),
                        weather: [Weather]? = [sampleWeather()]) -> DailyWeather {
    DailyWeather(currentTime: currentTime,
                 humidity: humidity,
                 clouds: clouds,
                 temperature: temperature,
                 weather: weather)
}

func sampleDailyTemperature(day: Double? = 89,
                            min: Double? = 75,
                            max: Double? = 96) -> DailyTemperature {
    DailyTemperature(day: day,
                     min: min,
                     max: max)
}

func sampleWeatherAlert(senderName: String? = "NWS Fort Worth TX",
                 event: String? = "Heat Advisory",
                 start: Date? = Date(),
                 end:  Date? = Date(),
                 description: String? = "* WHAT...Heat index values up to 107.\n\n* WHERE...A portion of north central Texas.\n\n*",
                 tags: [String]? = ["Extreme high temperature"]) -> WeatherAlert {
    WeatherAlert(senderName: senderName,
                 event: event,
                 start: start,
                 end: end,
                 description: description,
                 tags: tags)
}

func sampleWeather(id: Int? = 800,
                   main: String? = "Clear",
                   description: String? = "clear sky",
                   icon: String? = "01n") -> Weather {
    Weather(id: id, main: main, description: description, icon: icon)
}

func sampleCity(name: String = "Munich") -> City {
    City(name: name)
}


