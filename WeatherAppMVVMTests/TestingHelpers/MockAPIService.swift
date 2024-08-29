//
//  MockAPIService.swift
//  WeatherAppMVVMTests
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import XCTest
import Combine
@testable import WeatherAppMVVM

class MockAPIService: APIServiceProtocol {
    var fail: Bool
    
    init(fail: Bool = false) {
        self.fail = fail
    }
    
    func fetchWeather(lat: Double, lon: Double, excluded: String) -> AnyPublisher<Forecast, any Error> {
        if fail {
            return Fail(error: MockError.testError)
                .eraseToAnyPublisher()
        } else {
            let forecast = sampleForeCast()
            return Just(forecast)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    func fetchCity(lat: Double, lon: Double) -> AnyPublisher<[City], any Error> {
        if fail {
            return Fail(error: MockError.testError)
                .eraseToAnyPublisher()
        } else {
            let cities = [sampleCity()]
            return Just(cities)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    enum MockError: Error {
        case testError
    }
}
