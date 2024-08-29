//
//  Constants.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation

struct Constants {
    //TODO: We can confiutre user-agent, ipad interface support from constants later on
    
    struct AppSettings {
        static let apiKey = "262f64157afe277f1a0a89c062e47f68"
    }
    
    struct Error {
        static var domain = "WeatherAppMVVM"
        struct Loading {
            static let noInternet = "The internet connection appears to be offline"
            static let empty = "Data is not available"
            static let timeOut = "Update failed, try again"
            static func updateFailedWithError(_ msg: String) -> String { "Update failed, \(msg)"}
            static func failureWithError(_ msg: String) -> String {  "\(msg)"}
        }
    }
    
    //TODO: Api version can be remotely confiured later
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
