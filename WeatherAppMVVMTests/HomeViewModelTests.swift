//
//  HomeViewModelTests.swift
//  WeatherAppMVVMTests
//
//  Created by Chetankumar Dobariya on 29.08.24.
//

import XCTest
import Combine
import UIKit
@testable import WeatherAppMVVM

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        viewModel = HomeViewModel(apiService: MockAPIService())
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchWeatherWhenNoInternet() {
        //Given
        NetworkReachability.shared.isConnected = false
        
        //When
        viewModel.fetchWeather(lat: 33.95, lon: -96.5, excluded: "minutely")
        
        //Then
        XCTAssertEqual(viewModel.alertMessage, "No Internet Connection")
        XCTAssertNil(viewModel.forecast, "Weather Forecast should be nil")
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testFetchWeatherLoadingState() {
        //Given
        NetworkReachability.shared.isConnected = true
        
        //When
        let loadingExpectation = XCTestExpectation(description: "ViewModel is loading")
        let finishedExpectation = XCTestExpectation(description: "ViewModel finished loading")
        
        //Then
        viewModel.$isLoading
            .sink { isLoading in
                if isLoading {
                    loadingExpectation.fulfill()
                } else {
                    finishedExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.fetchWeather(lat: 33.95, lon: -96.5, excluded: "minutely")
        wait(for: [loadingExpectation, finishedExpectation], timeout: 2.0)
    }
    
    func testFetchWeatherSuccess() {
        //Given
        NetworkReachability.shared.isConnected = true
        
        //When
        let expectation = XCTestExpectation(description: "Fetch weather forecast successfully")
        viewModel.fetchWeather(lat: 33.95, lon: -96.5, excluded: "minutely")
        
        //Then
        viewModel.$forecast
            .sink { forecast in
                XCTAssertNotNil(forecast, "Weather forecast should be loaded")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    
    func testFetchWaetherFailure() {
        //Given
        NetworkReachability.shared.isConnected = true
        viewModel = HomeViewModel(apiService: MockAPIService(fail: true))
        
        //When
        let expectation = XCTestExpectation(description: "Handle fetch weather failure")
        
        //Then
        viewModel.$alertMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage,"The operation couldn’t be completed.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchWeather(lat: 33.95, lon: -96.5, excluded: "minutely")
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchCitySuccess() {
        //Given
        NetworkReachability.shared.isConnected = true
        
        //When
        let expectation = XCTestExpectation(description: "Fetch city successfully")
        viewModel.fetchCity(lat: 33.95, lon: -96.5)
        
        //Then
        viewModel.$cityName
            .sink { cityName in
                XCTAssertNotNil(cityName, "city should be loaded")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
    }
    
    
    func testFetchCityFailure() {
        //Given
        NetworkReachability.shared.isConnected = true
        viewModel = HomeViewModel(apiService: MockAPIService(fail: true))
        
        //When
        let expectation = XCTestExpectation(description: "Handle fetch city failure")
        
        //Then
        viewModel.$alertMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage,"The operation couldn’t be completed.")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.fetchCity(lat: 33.95, lon: -96.5)
        wait(for: [expectation], timeout: 1.0)
    }
}

