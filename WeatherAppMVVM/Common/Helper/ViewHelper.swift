//
//  ViewHelper.swift
//  WeatherAppMVVM
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import Foundation
import SwiftUI

protocol ViewHelperInterface {
    func saveCity(_ cityName: String)
    func getCityName() -> String?
    func saveLocation(_ location: LocationData)
    func getStoredLocation() -> LocationData?
}


class ViewHelper: ViewHelperInterface {
    static var shared = { ViewHelper() }()

    func saveCity(_ cityName: String) {
        guard !cityName.isEmpty else { return }
        UserDefaults.standard.setValue(cityName, forKey: "cityName")
    }
    
    func getCityName() -> String? {
        UserDefaults.standard.string(forKey: "cityName")
    }
    
    func saveLocation(_ location: LocationData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(location) {
            UserDefaults.standard.set(encoded, forKey: "savedLocation")
        }
    }
    func getStoredLocation() -> LocationData? {
        if let savedLocationData = UserDefaults.standard.data(forKey: "savedLocation") {
            let decoder = JSONDecoder()
            return try? decoder.decode(LocationData.self, from: savedLocationData)
        }
        return nil
    }
    
}
