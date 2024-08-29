//
//  Constants.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct Constants {
    //TODO: replace with your key
    struct AppSettings {
        static let apiKey = "262f64157afe277f1a0a89c062e47f68"
    }
    
    struct AppURL {
        static var baseUrl: URL {
            guard let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall") else {
                fatalError("baseUrl not found")
            }
            return url
        }
        static var geoURL: URL {
            guard let url = URL(string: "https://api.openweathermap.org/geo/1.0/reverse") else {
                fatalError("baseUrl not found")
            }
            return url
        }
    }
    
    
}
